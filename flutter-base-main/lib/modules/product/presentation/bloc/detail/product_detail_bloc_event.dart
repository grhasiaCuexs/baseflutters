import 'package:myeshop/coreapp/helpers/base_state.dart';

abstract class ProductDetailEvent extends BaseUiUIEvent<dynamic> {}

class OnGetProductDetail extends ProductDetailEvent {
  final String id;
  OnGetProductDetail(this.id);
}
