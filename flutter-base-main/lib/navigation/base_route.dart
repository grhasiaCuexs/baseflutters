import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:myeshop/coreapp/di/core_injection.dart';

/// A [GoRoute] wrapper that defaults to pushing routes onto the root navigator.
/// Useful for detail screens or flows that need to hide the BottomNavigationBar.
class RootGoRoute extends GoRoute {
  RootGoRoute({
    required super.path,
    super.name,
    super.builder,
    super.pageBuilder,
    super.redirect,
    super.routes,
    super.onExit,
    GlobalKey<NavigatorState>? parentNavigatorKey,
  }) : super(
          parentNavigatorKey: parentNavigatorKey ?? CoreInjection.rootNavigatorKey,
        );
}
