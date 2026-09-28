import 'package:myeshop/modules/product/domain/entities/product_entity.dart';
import 'package:myeshop/modules/product/domain/repositories/product_repository.dart';
import 'package:myeshop/modules/root/domain/result.dart';
import 'package:myeshop/modules/root/domain/base_usecase.dart';

class GetProductDetailUseCase extends BaseUseCase<ProductEntity, String> {
  final ProductRepository repository;

  GetProductDetailUseCase(this.repository);

  @override
  Future<Result<ProductEntity>> call(String param) {
    return repository.getProductDetail(param);
  }
}
