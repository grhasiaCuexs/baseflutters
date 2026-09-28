import 'package:myeshop/modules/root/domain/result.dart';

abstract class BaseUseCase<T, Params> {
  Future<Result<T>> call(Params param);
}
