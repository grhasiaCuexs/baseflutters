import 'package:json_annotation/json_annotation.dart';
import 'package:myeshop/modules/auth/main/data/models/response/data_signin.dart';
import 'package:myeshop/modules/auth/main/data/models/response/session_token.dart';

part 'session_signin.g.dart';

@JsonSerializable(explicitToJson: true)
class SessionSignIn extends SessionToken {
  SessionSignIn(super.token, super.expired, {required this.dataSignin});
  
  @JsonKey(name: 'data')
  final DataSignIn dataSignin;

  factory SessionSignIn.fromJson(Map<String, dynamic> json) => _$SessionSignInFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SessionSignInToJson(this);

  @override
  String toString() {
    return 'SignIn{token: $token, expired: $expired, dataSignin: $dataSignin}';
  }
}