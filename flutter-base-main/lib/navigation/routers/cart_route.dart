import 'package:myeshop/modules/root/presentation/ui/screen/underconstraction_screen.dart';
import 'package:myeshop/navigation/base_route.dart';
import 'package:myeshop/navigation/main_navigation.dart';

class CartRoute extends RootGoRoute {
  CartRoute({super.routes})
      : super(
          path: MainNavigation.cartLocation,
          name: 'cart',
          builder: (context, state) => const UnderConstructionScreen("Keranjang Belanja"),
        );
}
