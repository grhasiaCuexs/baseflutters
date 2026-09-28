import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myeshop/coreapp/di/core_injection.dart';
import 'package:myeshop/modules/auth/main/presentation/bloc/session/session_bloc.dart';
import 'package:myeshop/navigation/auth_navigation.dart';
import 'package:myeshop/navigation/main_navigation.dart';

class RootNavigation {
  static final List<RouteBase> routes = [
    MainNavigation.routes,
    AuthNavigation.routes,
  ];
}

class RootNavigationHelper {
  static final RootNavigationHelper _instance =
      RootNavigationHelper._internal();

  static RootNavigationHelper get instance => _instance;

  static late final GoRouter router;

  BuildContext get context =>
      router.routerDelegate.navigatorKey.currentContext!;

  GoRouterDelegate get routerDelegate => router.routerDelegate;

  GoRouteInformationParser get routeInformationParser =>
      router.routeInformationParser;

  String currentPath() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }

  factory RootNavigationHelper() {
    return _instance;
  }

  String? _redirectPathAfterLogin;
  
  void setRedirectPath(String path) {
    _redirectPathAfterLogin = path;
  }

  String? getRedirectPath() => _redirectPathAfterLogin;

  void clearRedirectPath() {
    _redirectPathAfterLogin = null;
  }

  RootNavigationHelper._internal() {
    final routes = RootNavigation.routes;
    router = GoRouter.routingConfig(
      initialLocation: MainNavigation.location,
      routingConfig: ValueNotifier<RoutingConfig>(
        RoutingConfig(
          routes: routes,
          redirect: _onRedirect, 
        ),
      ),
      debugLogDiagnostics: true,
      navigatorKey: CoreInjection.globaKeyNavigator(),
      errorPageBuilder: (context, state) {
        return MaterialPage(
          child: Text(
              "Error Screen Here:!\nError Message: ${state.error?.message}"),
        );
      },
    );
  }

  FutureOr<String?> _onRedirect(BuildContext context, GoRouterState state) {
    final sessionState = context.read<SessionBloc>().state;
    final hasLoggedIn = sessionState.uiData.statusLoggedInit;
    // debugPrint(
    //     "Masuk sini login status: $hasLoggedIn, init:$_isInit, path: ${state.fullPath}, path: ${state.matchedLocation}, redirect after login: $_redirectPathAfterLogin");

    if (hasLoggedIn) {
      if (state.fullPath?.startsWith(AuthNavigation.location) == true) {
        final redirect = _redirectPathAfterLogin ?? MainNavigation.location;
        _redirectPathAfterLogin = null;
        return redirect;
      }
      return null;
    }

    if (MainNavigation.featureMustLoginLocation.contains(state.fullPath)) {
      AuthNavigation.showMessageMustLogin(context);
      _redirectPathAfterLogin = state.fullPath;
      return AuthNavigation.location;
    }

    return null;
  }
}
