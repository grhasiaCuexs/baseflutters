import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myeshop/coreapp/helpers/base_state.dart';
import 'package:myeshop/coreapp/helpers/base_view.dart';
import 'package:myeshop/modules/product/domain/entities/product_entity.dart';
import 'package:myeshop/modules/product/presentation/bloc/detail/product_detail_bloc.dart';
import 'package:myeshop/modules/product/presentation/bloc/detail/product_detail_bloc_event.dart';
import 'package:myeshop/coreapp/presentation/widgets/shimmer_loading.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductDetailBloc>().add(OnGetProductDetail(widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: BaseViewGET<ProductDetailBloc, BaseUiState<ProductEntity, dynamic>>(
        loadingView: (context, state) => _buildShimmerLoading(),
        successView: (context, state) {
          if (state is! UiStateSuccess<ProductEntity, dynamic>) return Container();
          final data = state.data;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.network(
                  data.imageUrl,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${data.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        data.description,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const ShimmerBox(
            width: double.infinity,
            height: 300,
            borderRadius: 0,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ShimmerBox(width: 250, height: 28),
                const SizedBox(height: 8),
                const ShimmerBox(width: 100, height: 24),
                const SizedBox(height: 24),
                const ShimmerBox(width: 150, height: 20),
                const SizedBox(height: 12),
                const ShimmerBox(width: double.infinity, height: 16),
                const SizedBox(height: 8),
                const ShimmerBox(width: double.infinity, height: 16),
                const SizedBox(height: 8),
                const ShimmerBox(width: 200, height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
