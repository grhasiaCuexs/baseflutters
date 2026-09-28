import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myeshop/modules/root/presentation/ui/components/loading_progress.dart';
import 'package:myeshop/helpers/localization_extension.dart';
import 'package:myeshop/modules/auth/main/presentation/bloc/session/session_bloc.dart';
import 'package:myeshop/modules/auth/main/presentation/bloc/session/session_bloc_event.dart';
import 'package:myeshop/modules/root/data/helpers/exceptions/exception_messages.dart';
import 'package:myeshop/modules/root/data/helpers/exceptions/network_error_code.dart';
import 'package:myeshop/modules/root/data/helpers/exceptions/network_exception.dart';
import 'package:myeshop/modules/root/presentation/ui/components/paging/config_ui_paging.dart';
import 'package:myeshop/modules/root/presentation/ui/components/paging/paging_bloc.dart';

class BasePaging<
    T,
    E extends PagingEvent,
    U,
    BL extends PagingBloc<T, E, U>> extends StatefulWidget {
  const BasePaging(
      {super.key,
      this.onLoadEvent,
      required this.onGetItem,
      this.listenWhen,
      this.listener,
      this.builderWhen,
      this.onError,
      this.onErrorWithData,
      this.loadNextData = const CurrentLoad(),
      this.fullLoad = const LoadingProgress(),
      this.scrollPhysics,
      this.withDefaultScrollPhysics = true,
      this.customSearchView});

  final E Function(bool isFirstPage, String query)? onLoadEvent;
  final Widget Function(T item, int pos) onGetItem;
  final Widget Function(Exception? exception)? onError;
  final Widget Function(Exception? exception)? onErrorWithData;
  final Widget fullLoad;
  final Widget loadNextData;
  final bool Function(BasePageState<T, U>, BasePageState<T, U>)? listenWhen;
  final void Function(BuildContext, BasePageState<T, U>)? listener;
  final bool Function(BasePageState<T, U>, BasePageState<T, U>)? builderWhen;
  final ScrollPhysics? scrollPhysics;
  final bool withDefaultScrollPhysics;
  final Widget Function(TextEditingController editingController,
      Function(String query) onChange)? customSearchView;

  @override
  State<BasePaging<T, E, U, BL>> createState() =>
      _BasePagingState<T, E, U, BL>();
}

class _BasePagingState<
    T,
    E extends PagingEvent,
    U,
    BL extends PagingBloc<T, E, U>> extends State<BasePaging<T, E, U, BL>> {
  ScrollController controller = ScrollController();
  final TextEditingController editingController = TextEditingController();

  void _onScroll() {
    double maxScroll = controller.position.maxScrollExtent;
    double currentScroll = controller.position.pixels;

    if (currentScroll == maxScroll) {
      _loadEvent(query: editingController.text);
    }
  }

  void _loadEvent({bool isFirstPage = false, String query = ""}) {
    final bloc = BlocProvider.of<BL>(context);
    if (widget.onLoadEvent != null) {
      bloc.add(widget.onLoadEvent!.call(isFirstPage, query));
    } else {
      if (E == PagingEvent || E is PagingEvent) {
        bloc.add(PagingEvent(page: isFirstPage ? 1 : null, query: query) as E);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    controller.addListener(_onScroll);
    return BlocConsumer<BL, BasePageState<T, U>>(
      listenWhen: widget.listenWhen ??
          (previous, current) => previous.runtimeType != current.runtimeType,
      listener: (context, state) {
        widget.listener?.call(context, state);
        
        if (state case PagingStateFailure(:final exception)) {
          if (exception is NetworkException) {
            if (exception.code == NetworkErrorCode.unauthorized) {
              String message = exception.getMessage(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                dismissDirection: DismissDirection.up,
                content: Text(message),
              ));
              context.read<SessionBloc>().add(OnCheckSession());
            }
          }
        }
      },
      buildWhen: widget.builderWhen,
      builder: (context, state) {
        if (state is SearchPagingMixin) {
          return _withSearchView(state);
        }
        return _getUi(state);
      },
    );
  }

  void _onChangeSearch(String query) {
    _loadEvent(isFirstPage: true, query: query);
  }

  Widget _withSearchView(BasePageState<T, U> loaded) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
          child: widget.customSearchView != null
              ? widget.customSearchView!
                  .call(editingController, _onChangeSearch)
              : TextField(
                  onChanged: _onChangeSearch,
                  controller: editingController,
                  decoration: const InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(8.0)))),
                ),
        ),
        Expanded(child: _getUi(loaded)),
      ],
    );
  }

  @override
  void dispose() {
    controller.removeListener(_onScroll);
    super.dispose();
  }

  Widget _getUi(BasePageState<T, U> loaded) {
    switch (loaded) {
      case PagingStateIdle():
        return Container();
      case PagingStateLoading():
        if (loaded.sizeData == 0) return widget.fullLoad;
        return _createListView(loaded);
      case PagingStateSuccess():
        if (loaded.sizeData > 0) return _createListView(loaded);
        return _onEmptyPage();
      case PagingStateFailure(:final exception):
        if (loaded.sizeData > 0) return _createListView(loaded);
        return widget.onError != null
            ? widget.onError!.call(exception)
            : _onErrorPage(exception);
      default:
        return Container();
    }
  }

  _onErrorPage(Exception ex) {
    final ConfigUiPaging uiConfig = BaseConfigUiPaging();
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: uiConfig.baseLogoImage != null
                  ? Image(
                      image: uiConfig.baseLogoImage!,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              ex.getMessage(context),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () => _loadEvent(query: editingController.text),
              iconSize: 36,
              alignment: Alignment.center,
              icon: const Icon(
                Icons.refresh,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onEmptyPage() {
    final ConfigUiPaging uiConfig = BaseConfigUiPaging();
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: uiConfig.baseLogoImage != null
                  ? Image(
                      image: uiConfig.baseLogoImage!,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              context.getAppLocalizations().empty_data,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () =>
                  _loadEvent(isFirstPage: true, query: editingController.text),
              iconSize: 36,
              alignment: Alignment.center,
              icon: const Icon(
                Icons.refresh,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _createListView(BasePageState<T, U> loaded) {
    return RefreshIndicator(
      onRefresh: () async {
        _loadEvent(isFirstPage: true);
        editingController.clear();
      },
      child: ListView.builder(
        controller: controller,
        physics: widget.withDefaultScrollPhysics
            ? const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics())
            : widget.scrollPhysics,
        itemCount: (loaded.hasReachedMax) ? loaded.sizeData : loaded.sizeData + 1,
        itemBuilder: (context, index) => (index < loaded.sizeData)
            ? widget.onGetItem(loaded.data[index], index)
            : _checkOnExtraLine(loaded),
      ),
    );
  }

  Widget _checkOnExtraLine(BasePageState<T, U> loaded) {
    return switch (loaded) {
      PagingStateSuccess() || PagingStateLoading() => widget.loadNextData,
      PagingStateFailure(:final exception) => widget.onErrorWithData != null
          ? widget.onErrorWithData!.call(exception)
          : ErrorNextData(
              exception.getMessage(context),
              reload: () {
                _loadEvent(query: editingController.text);
              },
            ),
      _ => Container(),
    };
  }
}

class CurrentLoad extends StatelessWidget {
  const CurrentLoad({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class ErrorNextData extends StatelessWidget {
  const ErrorNextData(this.message, {super.key, required this.reload});
  final String message;
  final Function() reload;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline_outlined,
            color: Colors.red,
            size: 24,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
          ),
          IconButton(
            onPressed: reload,
            icon: const Icon(
              Icons.refresh_outlined,
              color: Colors.grey,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
