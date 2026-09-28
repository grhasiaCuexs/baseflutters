import 'package:myeshop/modules/auth/main/domain/repositories/session_repository.dart';
import 'package:myeshop/modules/root/domain/base_usecase.dart';
import 'package:myeshop/modules/root/domain/result.dart';

class RevokeSessionUseCase implements BaseUseCase<bool, void> {
  final SessionRepository _repository;

  RevokeSessionUseCase({required SessionRepository repository})
      : _repository = repository;

  @override
  Future<Result<bool>> call([void param]) {
    return _repository.revokeSession();
  }
}
