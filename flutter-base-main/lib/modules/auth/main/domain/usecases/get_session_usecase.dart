import 'package:myeshop/modules/auth/main/data/models/response/data_signin.dart';
import 'package:myeshop/modules/auth/main/domain/repositories/session_repository.dart';
import 'package:myeshop/modules/root/domain/base_usecase.dart';
import 'package:myeshop/modules/root/domain/result.dart';

class GetSessionDataUsecase
    implements BaseUseCase<DataSignIn?, void> {
  final SessionRepository _repository;

  GetSessionDataUsecase({required SessionRepository repository})
      : _repository = repository;

  @override
  Future<Result<DataSignIn?>> call([void param]) {
    return _repository.getSessionData();
  }
}
