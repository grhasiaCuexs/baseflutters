import 'package:myeshop/coreapp/helpers/base_state.dart';

sealed class SignInUIEvent extends BaseUiUIEvent {}

class OnSignInSubmitted extends SignInUIEvent {
  final String email;
  final String password;

  OnSignInSubmitted(this.email, this.password);
}
