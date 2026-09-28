import 'package:myeshop/modules/root/presentation/ui/components/paging/paging_bloc.dart';

class ProductListEvent extends PagingEvent {
  ProductListEvent({super.page, super.query});
}
