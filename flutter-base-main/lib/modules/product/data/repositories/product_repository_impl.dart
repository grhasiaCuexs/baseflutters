import 'package:myeshop/modules/product/domain/entities/product_entity.dart';
import 'package:myeshop/modules/product/domain/repositories/product_repository.dart';
import 'package:myeshop/modules/root/domain/base_paging_param.dart';
import 'package:myeshop/modules/root/domain/result.dart';

import 'package:myeshop/coreapp/data/datasource/network/feature_network_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final FeatureNetworkDataSource _networkDataSource;

  ProductRepositoryImpl(this._networkDataSource);

  @override
  Future<Result<List<ProductEntity>>> getProducts(PagingParam param) async {
    try {
      final skip = (param.page - 1) * param.size;
      final limit = param.size;
      
      final response = await _networkDataSource.getProducts(limit, skip);
      final products = response.products.map((model) => model.toEntity()).toList();
      
      return ResultSuccess(data: products);
    } catch (e) {
      return ResultError(error: Exception(e.toString()));
    }
  }

  @override
  Future<Result<ProductEntity>> getProductDetail(String id) async {
    try {
      final productId = int.parse(id);
      final response = await _networkDataSource.getProductDetail(productId);
      return ResultSuccess(data: response.toEntity());
    } catch (e) {
      return ResultError(error: Exception('Product not found'));
    }
  }
}
