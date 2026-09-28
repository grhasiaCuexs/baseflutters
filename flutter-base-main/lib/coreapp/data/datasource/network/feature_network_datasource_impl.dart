import 'package:myeshop/coreapp/data/api/api_service.dart';
import 'package:myeshop/coreapp/data/datasource/network/feature_network_datasource.dart';

import 'package:myeshop/modules/product/data/models/response/product_model.dart';
import 'package:myeshop/modules/product/data/models/response/product_paging_response.dart';

class FeatureNetworkDataSourceImpl implements FeatureNetworkDataSource {
  final ApiService _api;
  FeatureNetworkDataSourceImpl({required ApiService api}) : _api = api;

  @override
  Future<ProductPagingResponse> getProducts(int limit, int skip) {
    return _api.getProducts(limit, skip);
  }

  @override
  Future<ProductModel> getProductDetail(int id) {
    return _api.getProductDetail(id);
  }
}
