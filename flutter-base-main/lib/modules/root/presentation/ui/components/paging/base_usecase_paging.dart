import 'package:myeshop/modules/root/domain/base_paging_param.dart';
import 'package:myeshop/modules/root/domain/base_usecase.dart';

abstract class UseCasePaging<T, PARAM extends PagingParam> implements BaseUseCase<List<T>, PARAM> {}