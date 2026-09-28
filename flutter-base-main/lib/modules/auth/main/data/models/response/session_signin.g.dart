// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_signin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionSignIn _$SessionSignInFromJson(Map<String, dynamic> json) =>
    SessionSignIn(
      json['token'] as String? ?? '',
      json['expired'] as String? ?? '',
      dataSignin: DataSignIn.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SessionSignInToJson(SessionSignIn instance) =>
    <String, dynamic>{
      'token': instance.token,
      'expired': instance.expired,
      'data': instance.dataSignin.toJson(),
    };
