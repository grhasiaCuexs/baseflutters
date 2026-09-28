// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paging.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Paging<T> _$PagingFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => Paging<T>(
  currentPage: (json['current_page'] as num).toInt(),
  data: _$nullableGenericFromJson(json['data'], fromJsonT),
  from: (json['from'] as num?)?.toInt(),
  to: (json['to'] as num?)?.toInt(),
  perPage: (json['per_page'] as num).toInt(),
  total: (json['total'] as num).toInt(),
  lastPage: (json['last_page'] as num).toInt(),
  firstPageUrl: json['first_page_url'] as String?,
  lastPageUrl: json['last_page_url'] as String?,
  nextPageUrl: json['next_page_url'] as String?,
  prevPageUrl: json['prev_page_url'] as String?,
  path: json['path'] as String,
);

Map<String, dynamic> _$PagingToJson<T>(
  Paging<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'current_page': instance.currentPage,
  'data': _$nullableGenericToJson(instance.data, toJsonT),
  'from': instance.from,
  'to': instance.to,
  'per_page': instance.perPage,
  'total': instance.total,
  'last_page': instance.lastPage,
  'first_page_url': instance.firstPageUrl,
  'last_page_url': instance.lastPageUrl,
  'next_page_url': instance.nextPageUrl,
  'prev_page_url': instance.prevPageUrl,
  'path': instance.path,
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);
