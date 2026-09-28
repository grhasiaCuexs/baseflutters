import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myeshop/coreapp/di/features_injection.dart';
import 'package:myeshop/helpers/localization_extension.dart';
import 'package:myeshop/modules/product/presentation/bloc/list/product_list_bloc.dart';
import 'package:myeshop/modules/product/presentation/ui/product_list_view.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback? onNavigateToCart;
  final void Function(String id)? onNavigateToProductDetail;

  const HomeScreen({
    super.key,
    this.onNavigateToCart,
    this.onNavigateToProductDetail,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.getAppLocalizations();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/app_icon.png',
                height: 32,
                width: 32,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              l10n.app_name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: onNavigateToCart,
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => FeaturesInjection.get<ProductListBloc>(),
        child: ProductListView(
          onNavigateToDetail: onNavigateToProductDetail,
        ),
      ),
    );
  }
}
