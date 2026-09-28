import 'package:myeshop/modules/auth/main/presentation/bloc/session/session_bloc.dart';
import 'package:myeshop/modules/auth/main/presentation/bloc/session/session_bloc_event.dart';
import 'package:myeshop/modules/auth/main/presentation/helpers/session_action_listener.dart';

class SessionActionListenerImpl implements SessionActionListener {
  SessionActionListenerImpl(SessionBloc sessionBloc)
      : _sessionBloc = sessionBloc;

  final SessionBloc _sessionBloc;

  @override
  void onCheckSession() async {
    _sessionBloc.add(OnCheckSession());
  }

  @override
  void onRevokeSession() async {
    _sessionBloc.add(OnRevokeSession());
  }
}
