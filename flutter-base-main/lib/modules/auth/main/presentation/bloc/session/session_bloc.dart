import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myeshop/coreapp/helpers/base_state.dart';
import 'package:myeshop/modules/auth/main/data/models/response/data_signin.dart';
import 'package:myeshop/modules/auth/main/domain/usecases/get_session_usecase.dart';
import 'package:myeshop/modules/auth/main/domain/usecases/revoke_session_usecase.dart';
import 'package:myeshop/modules/auth/main/presentation/bloc/session/session_bloc_event.dart';
import 'package:myeshop/modules/auth/main/presentation/bloc/session/session_bloc_state.dart';
import 'package:myeshop/modules/root/domain/result.dart';

class SessionBloc extends MyBaseBloc<SessionUIEvent, DataSignIn, SessionUIState> {
  SessionBloc({
    required GetSessionDataUsecase getSessionUsecase,
    required RevokeSessionUseCase revokeSessionUseCase,
    bool statusLoggedInit = false,
    bool hasSplashScreenStart = false,
  })  : _getSessionUsecase = getSessionUsecase,
        _revokeSessionUseCase = revokeSessionUseCase,
        super(
          UiStateIdle<DataSignIn, SessionUIState>(SessionUIState(
            statusLoggedInit: statusLoggedInit,
            hasSplashScreenStart: hasSplashScreenStart,
          )),
        ) {
    on<OnCheckSession>(_onCheckSession);
    on<OnRevokeSession>(_onRevokeSession);
  }

  final GetSessionDataUsecase _getSessionUsecase;
  final RevokeSessionUseCase _revokeSessionUseCase;

  _onCheckSession(
      OnCheckSession event, Emitter<BaseUiState<DataSignIn, SessionUIState>> emitter) async {
    final result = await _getSessionUsecase();
    if (result is ResultSuccess) {
      emitter(UiStateSuccess<DataSignIn, SessionUIState>(
        data: result.data!,
        uiData: state.uiData.copyWith(statusLoggedInit: true),
      ));
    } else {
      emitter(UiStateFailure<DataSignIn, SessionUIState>(
        exception: result.error ?? Exception('Unknown error'),
        uiData: state.uiData.copyWith(statusLoggedInit: false),
      ));
    }
  }

  _onRevokeSession(
      OnRevokeSession event, Emitter<BaseUiState<DataSignIn, SessionUIState>> emitter) async {
    final result = await _revokeSessionUseCase.call();
    if (result is ResultSuccess && result.data == true) {
      emitter(UiStateFailure<DataSignIn, SessionUIState>(
        exception: Exception('Session revoked'),
        uiData: state.uiData.copyWith(statusLoggedInit: false),
      ));
    }
  }
}
