// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_paging_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductPagingResponse _$ProductPagingResponseFromJson(
  Map<String, dynamic> json,
) => ProductPagingResponse(
  products: (json['products'] as List<dynamic>)
      .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num).toInt(),
  skip: (json['skip'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
);

Map<String, dynamic> _$ProductPagingResponseToJson(
  ProductPagingResponse instance,
) => <String, dynamic>{
  'products': instance.products,
  'total': instance.total,
  'skip': instance.skip,
  'limit': instance.limit,
};
