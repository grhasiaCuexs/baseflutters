import 'package:json_annotation/json_annotation.dart';

part 'session_token.g.dart';

@JsonSerializable()
class SessionToken {
  @JsonKey(name: 'token', defaultValue: "")
  final String token;

  @JsonKey(name: 'expired', defaultValue: "")
  final String expired;

  SessionToken(this.token, this.expired);

  factory SessionToken.fromJson(Map<String, dynamic> json) =>
      _$SessionTokenFromJson(json);

  Map<String, dynamic> toJson() => _$SessionTokenToJson(this);

}