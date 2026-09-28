import 'package:myeshop/modules/product/domain/entities/product_entity.dart';
import 'package:myeshop/modules/product/domain/repositories/product_repository.dart';
import 'package:myeshop/modules/root/domain/base_paging_param.dart';
import 'package:myeshop/modules/root/domain/result.dart';
import 'package:myeshop/modules/root/presentation/ui/components/paging/base_usecase_paging.dart';

class GetProductsUseCase extends UseCasePaging<ProductEntity, PagingParam> {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  @override
  Future<Result<List<ProductEntity>>> call(PagingParam param) {
    return repository.getProducts(param);
  }
}
