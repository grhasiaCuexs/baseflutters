import 'package:myeshop/modules/auth/main/data/models/params/signup_param.dart';
import 'package:myeshop/modules/auth/main/domain/entities/signup_param.dart';

extension SignUpParamExt on SignUpParamEntity {
  SignUpParam toModel() {
    return SignUpParam(email, name, password);
  }
}
