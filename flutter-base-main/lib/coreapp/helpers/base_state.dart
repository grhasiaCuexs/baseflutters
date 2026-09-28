import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myeshop/modules/root/domain/base_usecase.dart';
import 'package:myeshop/modules/root/domain/result.dart';

// ============================================================
// SEALED BASE UI STATE
// ============================================================

/// Base class untuk UI State yang di-manage oleh BLoC.
/// Menggunakan pattern sealed class.
/// [T] = Tipe data dari hasil request API utama.
/// [U] = Tipe data untuk state UI tambahan (contoh: SessionUIState).
sealed class BaseUiState<T, U> extends Equatable {
  final U uiData;
  const BaseUiState(this.uiData);

  @override
  List<Object?> get props => [uiData];
}

class UiStateIdle<T, U> extends BaseUiState<T, U> {
  const UiStateIdle(super.uiData);
}

class UiStateLoading<T, U> extends BaseUiState<T, U> {
  const UiStateLoading(super.uiData);
}

class UiStateSuccess<T, U> extends BaseUiState<T, U> {
  final T data;
  const UiStateSuccess({required this.data, required U uiData}) : super(uiData);

  @override
  List<Object?> get props => [data, uiData];
}

class UiStateFailure<T, U> extends BaseUiState<T, U> {
  final Exception exception;
  const UiStateFailure({required this.exception, required U uiData})
      : super(uiData);

  @override
  List<Object?> get props => [exception, uiData];
}

/// Helper class untuk BLoC yang tidak memerlukan extra UI state.
class NoUiState extends Equatable {
  const NoUiState();

  @override
  List<Object?> get props => [];
}

// ============================================================
// UTILITIES
// ============================================================

/// Wrapper untuk mendukung nullable value di copyWith pattern.
/// Contoh: `copyWith(query: Wrapped.value(null))` akan set query ke null.
class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}

/// Mixin untuk event yang membawa parameter.
/// Harus dipasang pada event yang digunakan dengan [MyBaseBloc.onRequestUsecase].
mixin UiEventParam<PARAM> on BaseUiUIEvent<PARAM> {
  PARAM get param;
}

/// Mixin untuk header token.
mixin Header {
  String getHeaderToken() {
    return "";
  }
}

/// Base class untuk BLoC events.
abstract class BaseUiUIEvent<PARAM> extends Equatable {
  @override
  List<Object> get props => [];
}

// ============================================================
// MY BASE BLOC
// ============================================================

/// Base BLoC class yang mengatur state transitions secara otomatis.
///
/// [T] = Tipe model utama hasil dari request
/// [U] = Tipe DTO untuk state UI tambahan
class MyBaseBloc<E extends BaseUiUIEvent, T, U>
    extends Bloc<E, BaseUiState<T, U>> {
  MyBaseBloc(super.initialState);
  CancelToken? cancelToken;

  @override
  Future<void> close() {
    cancelToken?.cancel();
    return super.close();
  }

  /// Bind event ke UseCase dengan parameter otomatis dari [UiEventParam].
  void onRequestUsecase<EX extends E, PARAM>(
    BaseUseCase<T, PARAM> usecase, {
    bool Function(EX event, BaseUiState<T, U> state, Emitter<BaseUiState<T, U>> emitter)?
        onCheckRequestCondition,
    BaseUiState<T, U> Function(EX event, BaseUiState<T, U> state)? initState,
    EventTransformer<EX>? transformer,
    Future<BaseUiState<T, U>> Function()? onLoading,
    Future<BaseUiState<T, U>> Function(T result)? onSuccessResult,
    Future<BaseUiState<T, U>> Function(Exception exception)? onErrorResult,
    Future<BaseUiState<T, U>> Function(T? result, Exception? exception)? onFinishResult,
  }) {
    if (<EX>[] is! List<UiEventParam<PARAM>>) {
      throw UnimplementedError(
          "Harus pasang with UiEventParam<$PARAM> (mixin) kalau pake method onRequestUsecase biar tidak kena error. Error di class \"${EX.toString()}\". Contoh pasangnya: class ${EX.toString()} with UiEventParam<$PARAM>");
    }
    onRequest<EX>(
      onRequest: (event, state) {
        if (event is UiEventParam<PARAM>) {
          var eventParam = event as UiEventParam<PARAM>;
          return usecase.call(eventParam.param);
        } else {
          throw UnimplementedError(
              "Harus pasang with UiEventParam<$PARAM> (mixin) kalau pake method onRequestUsecase biar tidak kena error. Errornya di \"class ${event.runtimeType}\". Contoh pasangnya: class ${event.runtimeType} with UiEventParam<$PARAM>");
        }
      },
      onCheckRequestCondition: onCheckRequestCondition,
      initState: initState,
      transformer: transformer,
      onLoading: onLoading,
      onSuccessResult: onSuccessResult,
      onErrorResult: onErrorResult,
      onFinishResult: onFinishResult,
    );
  }

  /// Core request handler.
  /// Mengatur lifecycle: Loading → Request → Success/Error → Finish
  void onRequest<EX extends E>({
    required Future<Result<T>> Function(EX event, BaseUiState<T, U> state) onRequest,
    bool Function(EX event, BaseUiState<T, U> state, Emitter<BaseUiState<T, U>> emitter)?
        onCheckRequestCondition,
    BaseUiState<T, U> Function(EX event, BaseUiState<T, U> state)? initState,
    EventTransformer<EX>? transformer,
    Future<BaseUiState<T, U>> Function()? onLoading,
    Future<BaseUiState<T, U>> Function(T result)? onSuccessResult,
    Future<BaseUiState<T, U>> Function(Exception exception)? onErrorResult,
    Function(Exception exception)? onCompleteError,
    Function(T result)? onCompleteSuccess,
    Future<BaseUiState<T, U>> Function(T? result, Exception? exception)? onFinishResult,
  }) {
    super.on<EX>((event, emit) async {
      // Check condition
      if (onCheckRequestCondition != null &&
          !onCheckRequestCondition.call(event, state, emit)) {
        return;
      }

      // === LOADING ===
      if (onLoading == null) {
        BaseUiState<T, U> iState = initState != null ? initState.call(event, state) : state;
        emit(UiStateLoading<T, U>(iState.uiData));
      } else {
        BaseUiState<T, U> resultLoading = await onLoading.call();
        emit(resultLoading);
      }

      // === REQUEST ===
      Result<T> result;
      try {
        result = await onRequest(event, state);
      } catch (e) {
        debugPrint("On Catch base_state: $e");
        result = ResultError(error: Exception(e));
      }

      // === SUCCESS ===
      if (result is ResultSuccess) {
        BaseUiState<T, U> resultSuccess;
        if (onSuccessResult != null) {
          resultSuccess = await onSuccessResult.call(result.data as T);
        } else {
          resultSuccess = UiStateSuccess<T, U>(data: result.data as T, uiData: state.uiData);
        }
        emit(resultSuccess);
        onCompleteSuccess?.call(result.data as T);
        if (onFinishResult != null) {
          BaseUiState<T, U> resultFinish = await onFinishResult.call(result.data, null);
          emit(resultFinish);
        }
      }
      // === ERROR ===
      else {
        BaseUiState<T, U> resultError;
        if (onErrorResult != null) {
          resultError = await onErrorResult.call(result.error!);
        } else {
          resultError = UiStateFailure<T, U>(exception: result.error!, uiData: state.uiData);
        }
        emit(resultError);
        onCompleteError?.call(result.error!);
        if (onFinishResult != null) {
          BaseUiState<T, U> resultFinish = await onFinishResult.call(null, result.error);
          emit(resultFinish);
        }
      }
    }, transformer: transformer);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      print('onError -- bloc: ${error.runtimeType}, error: $error');
    }
    super.onError(error, stackTrace);
  }
}

