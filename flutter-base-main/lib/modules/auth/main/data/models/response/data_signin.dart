import 'package:json_annotation/json_annotation.dart';
part 'data_signin.g.dart';

@JsonSerializable(explicitToJson: true)
class DataSignIn {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "fullname")
  final int? fullname;
  
  DataSignIn({
    required this.id,
    required this.fullname
  });

  factory DataSignIn.fromJson(Map<String, dynamic> json) =>
      _$DataSignInFromJson(json);

  Map<String, dynamic> toJson() => _$DataSignInToJson(this);
}
