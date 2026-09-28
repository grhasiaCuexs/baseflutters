import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myeshop/navigation/routers/sign_in_route.dart';
import 'package:myeshop/navigation/routers/sign_up_route.dart';

class AuthNavigation {
  static const location = "/auth";
  static const signUpLocation = "$location/${SignUpNavigation.location}";

  static const authPathList = [signUpLocation];

  static void navigate(BuildContext context) {
    context.go(location);
  }

  static void navigateToSignUp(BuildContext context) {
    context.go(signUpLocation);
  }

  static final routes = SignInRoute(
    routes: [SignUpNavigation.route],
  );

  static showMessageMustLogin(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.black,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.up,
      content: Text(
        "Silahkan login untuk melanjutkan!",
        style: TextStyle(color: Colors.white),
      ),
    ));
  }
}

class SignUpNavigation {
  static const location = "sign_up";

  static final route = SignUpRoute();
}