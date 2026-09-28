import 'package:go_router/go_router.dart';
import 'package:myeshop/modules/account/presentation/ui/account_screen.dart';
import 'package:myeshop/navigation/main_navigation.dart';

class AccountRoute extends GoRoute {
  AccountRoute()
      : super(
          path: MainNavigation.accountLocation,
          name: 'account',
          builder: (context, state) => AccountScreen(
            onLogout: () {
              MainNavigation.logout(context);
            },
          ),
        );
}
