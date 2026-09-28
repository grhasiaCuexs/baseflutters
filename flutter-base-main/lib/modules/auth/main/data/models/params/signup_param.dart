import 'package:json_annotation/json_annotation.dart';

part 'signup_param.g.dart';

@JsonSerializable()
class SignUpParam {
  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'nama')
  final String? nama;

  @JsonKey(name: 'password')
  final String? password;

  SignUpParam(this.email, this.nama, this.password);

  factory SignUpParam.fromJson(Map<String, dynamic> json) =>
      _$SignUpParamFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpParamToJson(this);
}
