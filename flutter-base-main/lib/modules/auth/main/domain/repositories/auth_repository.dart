import 'package:myeshop/modules/root/domain/result.dart';
import 'package:myeshop/modules/auth/main/domain/entities/signin_param.dart';
import 'package:myeshop/modules/auth/main/domain/entities/signup_param.dart';
import 'package:myeshop/modules/auth/main/data/models/response/session_signin.dart';

abstract class AuthRepository {
  Future<Result<SessionSignIn>> postSignIn(SignInParamEntity param);
  Future<Result<SessionSignIn>> postSignUp(SignUpParamEntity param);
}
