import 'package:go_router/go_router.dart';
import 'package:myeshop/modules/home/presentation/ui/home_screen.dart';
import 'package:myeshop/navigation/main_navigation.dart';
import 'package:myeshop/navigation/routers/product_route.dart';

class HomeRoute extends GoRoute {
  HomeRoute({super.routes})
      : super(
          path: MainNavigation.location,
          name: 'home',
          builder: (context, state) => HomeScreen(
            onNavigateToCart: () => MainNavigation.navigateToCart(context),
            onNavigateToProductDetail: (id) => ProductDetailRoute.navigate(context, id),
          ),
        );
}
