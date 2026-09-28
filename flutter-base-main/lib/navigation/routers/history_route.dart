import 'package:go_router/go_router.dart';
import 'package:myeshop/modules/root/presentation/ui/screen/underconstraction_screen.dart';
import 'package:myeshop/navigation/main_navigation.dart';

class HistoryRoute extends GoRoute {
  HistoryRoute()
      : super(
          path: MainNavigation.history,
          name: 'history',
          builder: (context, state) => const UnderConstructionScreen("History"),
        );
}
