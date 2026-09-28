import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myeshop/coreapp/helpers/base_state.dart';
import 'package:myeshop/coreapp/helpers/constants.dart';
import 'package:myeshop/modules/root/data/helpers/exceptions/paging_exception.dart';
import 'package:myeshop/modules/root/domain/base_paging_param.dart';
import 'package:myeshop/modules/root/domain/result.dart';
import 'package:myeshop/modules/root/presentation/ui/components/paging/base_usecase_paging.dart';

// ============================================================
// BASE PAGE STATE (SEALED)
// ============================================================

sealed class BasePageState<T, U> extends Equatable {
  final List<T> data;
  final bool hasReachedMax;
  final U uiData;

  const BasePageState({
    this.data = const [],
    this.hasReachedMax = false,
    required this.uiData,
  });

  int get sizeData => data.length;

  @override
  List<Object?> get props => [data, hasReachedMax, uiData];
}

class PagingStateIdle<T, U> extends BasePageState<T, U> {
  const PagingStateIdle({super.data, super.hasReachedMax, required super.uiData});
}

class PagingStateLoading<T, U> extends BasePageState<T, U> {
  const PagingStateLoading({super.data, super.hasReachedMax, required super.uiData});
}

class PagingStateSuccess<T, U> extends BasePageState<T, U> {
  const PagingStateSuccess({required super.data, required super.hasReachedMax, required super.uiData});
}

class PagingStateFailure<T, U> extends BasePageState<T, U> {
  final Exception exception;
  const PagingStateFailure({required this.exception, required super.data, required super.hasReachedMax, required super.uiData});

  @override
  List<Object?> get props => super.props..add(exception);
}

// ============================================================
// SEARCH PAGING MIXIN
// ============================================================

mixin SearchPagingMixin<T, U> on BasePageState<T, U> {
  String getQuery();
  BasePageState<T, U> copyQueryOnly(String? query);
}

// ============================================================
// PAGING EVENT
// ============================================================

class PagingEvent extends BaseUiUIEvent {
  PagingEvent({this.page, this.query = ""});

  final int? page;
  final int initSizePerPage = Constants.initPaging;
  final int nextSizePerPage = Constants.sizePerPage;
  final String query;
}

// ============================================================
// PAGING BLOC
// ============================================================

abstract class PagingBloc<T, E extends PagingEvent, U> extends Bloc<E, BasePageState<T, U>> {
  static const Duration defaultDebounce = Duration(milliseconds: 1000);

  PagingBloc(super.initialState);

  CancelToken? cancelToken;

  @override
  Future<void> close() {
    cancelToken?.cancel();
    return super.close();
  }

  void onEventRequestPaging<Ex extends E, P extends PagingParam>(
      UseCasePaging<T, P> useCasePaging,
      {P Function(PagingParam param, Ex event)? onUpdateParam,
      EventTransformer<Ex>? transformer}) {
    super.on<Ex>(
      (event, emit) async {
        _setQuery(event.query, emit);
        await requestPage(
          emit,
          initSizePerPage: event.initSizePerPage,
          nextSizePerPage: event.nextSizePerPage,
          toPage: event.page,
          qFind: event.query,
          onRequest: (param) {
            P requestParam;
            if (onUpdateParam != null) {
              requestParam = onUpdateParam.call(param, event);
            } else {
              requestParam = param as P;
            }
            return useCasePaging(requestParam);
          },
        );
      },
      transformer: transformer ??
          (state is SearchPagingMixin
              ? queryTransformer<Ex>(defaultDebounce)
              : transformer),
    );
  }

  void onRequestPaging<P extends PagingParam>(UseCasePaging<T, P> useCasePaging,
      {P Function(PagingParam param)? onUpdateParam,
      EventTransformer<E>? transformer}) {
    super.on<E>(
      (event, emit) async {
        _setQuery(event.query, emit);
        await requestPage(
          emit,
          initSizePerPage: event.initSizePerPage,
          nextSizePerPage: event.nextSizePerPage,
          toPage: event.page,
          qFind: event.query,
          onRequest: (param) {
            P requestParam;
            if (onUpdateParam != null) {
              requestParam = onUpdateParam.call(param);
            } else {
              requestParam = param as P;
            }
            return useCasePaging(requestParam);
          },
        );
      },
      transformer: transformer ??
          (state is SearchPagingMixin
              ? queryTransformer<E>(defaultDebounce)
              : transformer),
    );
  }

  void _setQuery(String query, Emitter<BasePageState<T, U>> emit) {
    if (state is SearchPagingMixin) {
      final stateMix = state as SearchPagingMixin;
      debugPrint(
          "queryTransformer SearchPagingMixin ${stateMix.getQuery()} == $query");
      if (stateMix.getQuery() != query) {
        emit(stateMix.copyQueryOnly(query) as BasePageState<T, U>);
      }
    }
  }

  Future<void> requestPage(
    Emitter<BasePageState<T, U>> emit, {
    required Future<Result<List<T>>> Function(PagingParam param) onRequest,
    Future<BasePageState<T, U>> Function(List<T> result)? onSuccessResult,
    Future<BasePageState<T, U>> Function(Exception exception, bool isEndOfPage)? onErrorResult,
    int initSizePerPage = Constants.sizePerPage,
    int nextSizePerPage = Constants.sizePerPage,
    int? toPage,
    String qFind = "",
  }) async {
    if (state.hasReachedMax && toPage == null) {
      return;
    }

    PagingParam param;

    if (toPage != null) {
      param = PagingParam(toPage, initSizePerPage, q: qFind);
    } else if (state is PagingStateIdle) {
      param = PagingParam(1, initSizePerPage, q: qFind);
    } else {
      final page = state.sizeData ~/ nextSizePerPage;
      param = PagingParam(page + 1, nextSizePerPage, q: qFind);
    }

    final isStartPage = param.page == 1 || toPage != null;
    
    if (isStartPage) {
      emit(PagingStateLoading<T, U>(data: const [], hasReachedMax: false, uiData: state.uiData));
    } else {
      emit(PagingStateLoading<T, U>(data: state.data, hasReachedMax: state.hasReachedMax, uiData: state.uiData));
    }

    final resultList = await onRequest(param);

    if (resultList is ResultSuccess) {
      List<T> currentData = !isStartPage ? state.data : [];
      List<T> newData = resultList.data ?? [];
      
      final totalData = currentData + newData;
      final reachedMax = newData.length < param.size;

      if (onSuccessResult == null) {
        emit(PagingStateSuccess<T, U>(
          data: totalData,
          hasReachedMax: reachedMax,
          uiData: state.uiData,
        ));
      } else {
        emit(await onSuccessResult(totalData));
      }
    } else {
      final exception = resultList.error ?? Exception();
      final hasReachedMax = exception is PagingException;
      
      if (onErrorResult == null) {
        emit(PagingStateFailure<T, U>(
          exception: exception,
          data: state.data,
          hasReachedMax: hasReachedMax,
          uiData: state.uiData,
        ));
      } else {
        emit(await onErrorResult(exception, hasReachedMax));
      }
    }
  }

  EventTransformer<EQ> queryTransformer<EQ extends E>(Duration duration) {
    return (events, mapper) {
      Timer? debounce;
      final debounceTransformer = StreamTransformer<EQ, EQ>.fromHandlers(
        handleData: (data, sink) {
          if (debounce?.isActive ?? false) {
            debounce?.cancel();
          }
          final bool noDebounce;

          if (state is SearchPagingMixin) {
            final oldQuery = (state as SearchPagingMixin).getQuery();
            debugPrint("queryTransformer $oldQuery == ${data.query}");

            if (data.query.isEmpty && oldQuery.isEmpty && data.page == 1) {
              noDebounce = true;
            } else {
              noDebounce = (data.query.isEmpty && oldQuery == data.query) ||
                  (data.page == null && oldQuery == data.query);
            }
          } else {
            noDebounce = false;
          }
          debugPrint(
              "queryTransformer page: ${data.page}, noDebounce $noDebounce");
          if (noDebounce) {
            sink.add(data);
          } else {
            debounce = Timer(duration, () {
              sink.add(data);
            });
          }
        },
      );
      return droppable<EQ>().call(events.transform(debounceTransformer), mapper);
    };
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      print('onError -- bloc: ${error.runtimeType}, error: $error');
    }
    super.onError(error, stackTrace);
  }
}
