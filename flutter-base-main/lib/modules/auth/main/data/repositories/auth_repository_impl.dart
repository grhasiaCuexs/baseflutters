import 'package:myeshop/modules/auth/main/data/models/response/session_signin.dart';
import 'package:myeshop/modules/auth/main/domain/entities/signin_param.dart';
import 'package:myeshop/modules/auth/main/domain/entities/signup_param.dart';
import 'package:myeshop/modules/auth/main/domain/repositories/auth_repository.dart';
import 'package:myeshop/modules/root/domain/result.dart';
import 'package:myeshop/modules/auth/main/data/models/response/data_signin.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Result<SessionSignIn>> postSignIn(SignInParamEntity param) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Mock login statis
    if (param.email == 'test@mail.com' && param.password == 'password') {
      final dataSignIn = DataSignIn(id: '123', fullname: 1); // Mock fullname int
      final session = SessionSignIn('mock-token-123', '2030-01-01T00:00:00Z', dataSignin: dataSignIn);
      return ResultSuccess(data: session);
    } else {
      return ResultError(error: Exception('Invalid email or password'));
    }
  }

  @override
  Future<Result<SessionSignIn>> postSignUp(SignUpParamEntity param) {
    // TODO: implement postSignUp
    throw UnimplementedError();
  }

}