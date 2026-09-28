import 'package:myeshop/modules/auth/main/data/models/params/signin_param.dart';
import 'package:myeshop/modules/auth/main/domain/entities/signin_param.dart';

extension SignInParamExt on SignInParamEntity {
  SignInParam toModel() {
    return SignInParam(email, password);
  }
}
