import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myeshop/coreapp/di/features_injection.dart';
import 'package:myeshop/modules/product/presentation/bloc/detail/product_detail_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:myeshop/modules/product/presentation/ui/product_detail_screen.dart';
import 'package:myeshop/navigation/base_route.dart';

class ProductDetailRoute extends RootGoRoute {
  static void navigate(BuildContext context, String id) => context.push('/product/$id');

  ProductDetailRoute({
    super.parentNavigatorKey,
  }) : super(
          path: 'product/:id',
          name: 'product-detail',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return BlocProvider(
              create: (context) => FeaturesInjection.get<ProductDetailBloc>(),
              child: ProductDetailScreen(productId: id),
            );
          },
        );
}
