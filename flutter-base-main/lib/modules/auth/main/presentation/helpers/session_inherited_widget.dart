import 'package:flutter/widgets.dart';
import 'package:myeshop/modules/auth/main/presentation/helpers/session_action_listener.dart';

class SessionInheritedWidget extends InheritedWidget {
  const SessionInheritedWidget({super.key, required super.child, required this.listener});
  final SessionActionListener listener;

  @override
  bool updateShouldNotify(SessionInheritedWidget oldWidget) {
    return oldWidget.listener != listener;
  }

  static SessionInheritedWidget? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SessionInheritedWidget>();
  }

  static SessionInheritedWidget of(BuildContext context) {
    final SessionInheritedWidget? result = maybeOf(context);
    assert(result != null, 'No SessionInheritedWidget found in context');
    return result!;
  }
}