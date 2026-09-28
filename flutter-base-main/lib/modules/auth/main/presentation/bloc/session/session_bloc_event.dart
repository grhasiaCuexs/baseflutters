import 'package:myeshop/coreapp/helpers/base_state.dart';

abstract class SessionUIEvent extends BaseUiUIEvent {}

class OnCheckSession extends SessionUIEvent {
  OnCheckSession();
}

class OnRevokeSession extends SessionUIEvent {}
