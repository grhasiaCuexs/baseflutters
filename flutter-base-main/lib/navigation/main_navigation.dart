import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myeshop/modules/auth/main/presentation/bloc/session/session_bloc.dart';
import 'package:myeshop/modules/auth/main/presentation/helpers/session_inherited_widget.dart';
import 'package:myeshop/modules/main/presentation/ui/main_screen.dart';
import 'package:myeshop/navigation/auth_navigation.dart';
import 'package:myeshop/navigation/root_navigation.dart';
import 'package:myeshop/navigation/routers/account_route.dart';
import 'package:myeshop/navigation/routers/cart_route.dart';
import 'package:myeshop/navigation/routers/history_route.dart';
import 'package:myeshop/navigation/routers/home_route.dart';
import 'package:myeshop/navigation/routers/product_route.dart';

enum MenuBottomNav {
  home(MainNavigation.location),
  history(MainNavigation.history),
  account(MainNavigation.accountLocation);

  const MenuBottomNav(this.location);
  final String location;
}

class MainNavigation {
  static const location = "/";
  static const history = "/history";
  static const accountLocation = "/account";
  static const cartLocation = "/cart";

  static const String prefixFeature = "";

  static const featureMustLoginLocation = [
    history,
    accountLocation,
    cartLocation,
  ];

  static int currentMenuBotNavAfterLogin = 0;

  static void navigate(BuildContext context) {
    context.go(location);
  }

  static void logout(BuildContext context) {
    SessionInheritedWidget.of(context).listener.onRevokeSession();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.black,
        behavior: SnackBarBehavior.floating,
        content: Text(
          "Anda berhasil logout",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
    context.go(location);
  }

  static void onTapBottomNav(
    BuildContext context,
    int index,
    StatefulNavigationShell navigationShell,
  ) {
    final hasLogged = context.read<SessionBloc>().state.uiData.hasLogged;

    if (!hasLogged && (index == 1 || index == 2)) {
      AuthNavigation.showMessageMustLogin(context);
      RootNavigationHelper.instance.setRedirectPath(
        index == 1 ? MainNavigation.history : MainNavigation.accountLocation,
      );
      context.push(AuthNavigation.location);
      return;
    }

    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  static void navigateToCart(BuildContext context) {
    final hasLogged = context.read<SessionBloc>().state.uiData.hasLogged;
    if (!hasLogged) {
      AuthNavigation.showMessageMustLogin(context);
      RootNavigationHelper.instance.setRedirectPath(cartLocation);
      context.push(AuthNavigation.location);
    } else {
      context.push(cartLocation);
    }
  }

  static final featureRoutes = <RouteBase>[ProductDetailRoute(), CartRoute()];

  static final routes = StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return MainScreen(
        navigationShell: navigationShell,
        onTapTab: (index) => onTapBottomNav(context, index, navigationShell),
      );
    },
    branches: [
      StatefulShellBranch(
        routes: [
          HomeRoute(routes: [...featureRoutes]),
        ],
      ),
      StatefulShellBranch(routes: [HistoryRoute()]),
      StatefulShellBranch(routes: [AccountRoute()]),
    ],
  );
}
