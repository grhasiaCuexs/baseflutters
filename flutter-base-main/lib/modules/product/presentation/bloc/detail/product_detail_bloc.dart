import 'package:myeshop/coreapp/helpers/base_state.dart';
import 'package:myeshop/modules/product/domain/entities/product_entity.dart';
import 'package:myeshop/modules/product/domain/usecases/get_product_detail_usecase.dart';
import 'package:myeshop/modules/product/presentation/bloc/detail/product_detail_bloc_event.dart';

class ProductDetailBloc extends MyBaseBloc<ProductDetailEvent, ProductEntity, dynamic> {
  final GetProductDetailUseCase getProductDetailUseCase;

  ProductDetailBloc(this.getProductDetailUseCase) : super(const UiStateIdle(null)) {
    onRequest<OnGetProductDetail>(
      onRequest: (event, state) => getProductDetailUseCase(event.id),
    );
  }
}
