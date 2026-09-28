import 'package:myeshop/modules/product/data/models/response/product_model.dart';
import 'package:myeshop/modules/product/data/models/response/product_paging_response.dart';

abstract class FeatureNetworkDataSource {
  Future<ProductPagingResponse> getProducts(int limit, int skip);
  Future<ProductModel> getProductDetail(int id);
}
