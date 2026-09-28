import 'package:myeshop/modules/root/domain/base_usecase.dart';
import 'package:myeshop/modules/root/domain/result.dart';
import 'package:myeshop/modules/auth/main/domain/entities/signin_param.dart';
import 'package:myeshop/modules/auth/main/domain/repositories/auth_repository.dart';
import 'package:myeshop/modules/auth/main/data/models/response/session_signin.dart';
import 'package:myeshop/modules/auth/main/domain/repositories/session_repository.dart';

class SignInUseCase
    implements BaseUseCase<SessionSignIn, SignInParamEntity> {
  SignInUseCase(AuthRepository repository, SessionRepository sessionRepository) : _repository = repository, _sessionRepository = sessionRepository;
  final AuthRepository _repository;
  final SessionRepository _sessionRepository;

  @override
  Future<Result<SessionSignIn>> call(SignInParamEntity param) async {
    Result<SessionSignIn> resp = await _repository.postSignIn(param);
    if (resp.data != null) {
      await _sessionRepository.saveSession(resp.data!);
    }
    return resp;
  }
}
