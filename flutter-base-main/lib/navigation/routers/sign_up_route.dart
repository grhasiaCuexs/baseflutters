import 'package:go_router/go_router.dart';
import 'package:myeshop/modules/root/presentation/ui/screen/underconstraction_screen.dart';
import 'package:myeshop/navigation/auth_navigation.dart';

class SignUpRoute extends GoRoute {
  SignUpRoute()
      : super(
          path: SignUpNavigation.location,
          name: 'sign-up',
          builder: (context, state) => const UnderConstructionScreen("Sign Up"),
        );
}
