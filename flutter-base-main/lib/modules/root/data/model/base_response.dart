import 'package:json_annotation/json_annotation.dart';
part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, explicitToJson: true)
class BaseResponse<T> {
  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "code")
  final int code;

  @JsonKey(name: "data")
  final T? data;

  BaseResponse({
    this.message,
    this.code = 0,
    this.data,
  });

  factory BaseResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseResponseFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$BaseResponseToJson<T>(this, toJsonT);
}
