import 'package:myeshop/modules/root/domain/base_paging_param.dart';
import 'package:myeshop/modules/root/domain/result.dart';
import 'package:myeshop/modules/product/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<Result<List<ProductEntity>>> getProducts(PagingParam param);
  Future<Result<ProductEntity>> getProductDetail(String id);
}
