// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionToken _$SessionTokenFromJson(Map<String, dynamic> json) => SessionToken(
  json['token'] as String? ?? '',
  json['expired'] as String? ?? '',
);

Map<String, dynamic> _$SessionTokenToJson(SessionToken instance) =>
    <String, dynamic>{'token': instance.token, 'expired': instance.expired};
