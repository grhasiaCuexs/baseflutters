import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myeshop/coreapp/helpers/base_state.dart';
import 'package:myeshop/modules/auth/main/data/models/response/session_signin.dart';
import 'package:myeshop/modules/auth/main/domain/entities/signin_param.dart';
import 'package:myeshop/modules/auth/main/domain/usecases/signin_usecase.dart';
import 'package:myeshop/modules/auth/main/presentation/bloc/signin/signin_bloc_event.dart';
import 'package:myeshop/modules/auth/main/presentation/bloc/signin/signin_bloc_state.dart';
import 'package:myeshop/modules/root/domain/result.dart';

class SignInBloc extends MyBaseBloc<SignInUIEvent, SessionSignIn, SignInUIState> {
  SignInBloc({
    required SignInUseCase signInUseCase,
  })  : _signInUseCase = signInUseCase,
        super(
          const UiStateIdle<SessionSignIn, SignInUIState>(SignInUIState()),
        ) {
    on<OnSignInSubmitted>(_onSignInSubmitted);
  }

  final SignInUseCase _signInUseCase;

  Future<void> _onSignInSubmitted(
      OnSignInSubmitted event, Emitter<BaseUiState<SessionSignIn, SignInUIState>> emitter) async {
    emitter(UiStateLoading<SessionSignIn, SignInUIState>(state.uiData));
    final param = SignInParamEntity(event.email, event.password);
    final result = await _signInUseCase(param);
    if (result is ResultSuccess) {
      emitter(UiStateSuccess<SessionSignIn, SignInUIState>(
        data: result.data!,
        uiData: state.uiData,
      ));
    } else {
      emitter(UiStateFailure<SessionSignIn, SignInUIState>(
        exception: result.error ?? Exception('Unknown error'),
        uiData: state.uiData,
      ));
    }
  }
}
