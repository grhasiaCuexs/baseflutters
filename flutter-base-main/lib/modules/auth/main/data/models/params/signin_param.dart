import 'package:json_annotation/json_annotation.dart';

part 'signin_param.g.dart';

@JsonSerializable()
class SignInParam {
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'password')
  final String password;

  SignInParam(this.email, this.password);

  factory SignInParam.fromJson(Map<String, dynamic> json) =>
      _$SignInParamFromJson(json);

  Map<String, dynamic> toJson() => _$SignInParamToJson(this);
}
