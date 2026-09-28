import 'package:flutter/material.dart';
import 'package:myeshop/modules/root/presentation/ui/components/loading_progress.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myeshop/coreapp/helpers/base_state.dart';
import 'package:myeshop/modules/auth/main/presentation/bloc/session/session_bloc.dart';
import 'package:myeshop/modules/auth/main/presentation/bloc/session/session_bloc_event.dart';
import 'package:myeshop/modules/root/data/helpers/exceptions/exception_messages.dart';
import 'package:myeshop/modules/root/data/helpers/exceptions/network_error_code.dart';
import 'package:myeshop/modules/root/data/helpers/exceptions/network_exception.dart';

class BaseViewPOST<B extends StateStreamable<S>,
    S extends BaseUiState<dynamic, dynamic>> extends StatelessWidget {
  const BaseViewPOST({
    super.key,
    required this.builder,
    required this.onIdle,
    required this.onSuccess,
    this.onGetState,
    this.listener,
    this.listenWhen,
    this.withDialog,
  });
  final Widget Function(BuildContext, S) builder;
  final Function() onIdle;
  final Function(S) onSuccess;
  final bool? withDialog;

  /// Callback opsional untuk mendapatkan BaseUiState dari state.
  final BaseUiState<dynamic, dynamic>? Function(S)? onGetState;
  final Function(BuildContext, S)? listener;
  final BlocListenerCondition<S>? listenWhen;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<B, S>(
      listenWhen: listenWhen ??
          (previous, current) {
            bool listen = previous != current;
            return listen;
          },
      listener: (context, state) {
        final reqState = onGetState?.call(state) ?? state;

        void dismissDialog() {
          if (withDialog == null) {
            Navigator.of(context, rootNavigator: true).pop('dialog');
          }
          onIdle();
        }

        switch (reqState) {
          case UiStateLoading():
            if (withDialog == null) {
              showDialog<String>(
                useRootNavigator: true,
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return const LoadingProgress();
                },
              ).then((value) {
                debugPrint(value);
              });
            }
          case UiStateSuccess():
            if (withDialog == null) dismissDialog();
            onSuccess(state);
          case UiStateFailure(:final exception):
            dismissDialog();
            String message = exception.getMessage(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              dismissDirection: DismissDirection.up,
              content: Text(message),
            ));

            if (exception is NetworkException) {
              if (exception.code == NetworkErrorCode.unauthorized) {
                context.read<SessionBloc>().add(OnCheckSession());
              }
            }
          case UiStateIdle():
            break;
        }

        listener?.call(context, state);
      },
      builder: builder,
    );
  }
}

class BaseViewGET<B extends StateStreamable<S>,
    S extends BaseUiState<dynamic, dynamic>> extends StatelessWidget {
  const BaseViewGET({
    super.key,
    required this.successView,
    this.loadingView,
    this.errorView,
    this.onCallRefresh,
    this.listener,
    this.onGetState,
    this.listenWhen,
  });
  final Widget Function(BuildContext, S) successView;
  final Widget Function(BuildContext, S)? loadingView;
  final Widget Function(BuildContext, S)? errorView;
  final Function()? onCallRefresh;
  final Function(BuildContext, S)? listener;

  /// Callback opsional untuk mendapatkan BaseUiState dari state.
  final BaseUiState<dynamic, dynamic>? Function(S)? onGetState;
  final BlocListenerCondition<S>? listenWhen;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<B, S>(
      listenWhen: listenWhen ??
          (previous, current) {
            bool listen = previous != current;
            return listen;
          },
      listener: (context, state) {
        final reqState = onGetState?.call(state) ?? state;
        if (reqState case UiStateFailure(:final exception)) {
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
        listener?.call(context, state);
      },
      builder: (context, state) {
        Widget requestView() {
          final reqState =
              onGetState?.call(state) ?? state;
          return switch (reqState) {
            UiStateLoading() =>
              loadingView?.call(context, state) ?? const LoadingProgress(),
            UiStateSuccess() => onCallRefresh != null
                ? RefreshIndicator(
                    onRefresh: () async {
                      onCallRefresh?.call();
                    },
                    child: successView.call(context, state),
                  )
                : successView.call(context, state),
            UiStateFailure(:final exception) => errorView != null
                ? errorView!.call(context, state)
                : ErrorNetworkView(
                    message: exception.getMessage(context),
                    onCallRefresh: onCallRefresh,
                  ),
            UiStateIdle() => Container(),
          };
        }

        return requestView();
      },
    );
  }
}

class ErrorNetworkView extends StatelessWidget {
  const ErrorNetworkView(
      {super.key, required this.message, this.onCallRefresh});
  final String message;
  final Function()? onCallRefresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_outlined,
              color: Colors.red,
              size: 80,
            ),
            const SizedBox(height: 32),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
            onCallRefresh != null
                ? IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: onCallRefresh,
                    iconSize: 36,
                    alignment: Alignment.center,
                    icon: const Icon(
                      Icons.refresh,
                      color: Colors.black87,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

