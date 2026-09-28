import 'package:myeshop/modules/product/domain/entities/product_entity.dart';
import 'package:myeshop/modules/product/domain/usecases/get_products_usecase.dart';
import 'package:myeshop/modules/product/presentation/bloc/list/product_list_bloc_event.dart';
import 'package:myeshop/modules/root/presentation/ui/components/paging/paging_bloc.dart';
import 'package:myeshop/modules/root/domain/base_paging_param.dart';

class ProductListBloc extends PagingBloc<ProductEntity, ProductListEvent, dynamic> {
  final GetProductsUseCase getProductsUseCase;

  ProductListBloc(this.getProductsUseCase) : super(const PagingStateIdle(uiData: null)) {
    onRequestPaging<PagingParam>(
      getProductsUseCase,
      onUpdateParam: (param) => param,
    );
  }
}
