import 'package:json_annotation/json_annotation.dart';
import 'package:myeshop/modules/product/data/models/response/product_model.dart';

part 'product_paging_response.g.dart';

@JsonSerializable()
class ProductPagingResponse {
  @JsonKey(name: 'products')
  final List<ProductModel> products;
  @JsonKey(name: 'total')
  final int total;
  @JsonKey(name: 'skip')
  final int skip;
  @JsonKey(name: 'limit')
  final int limit;

  ProductPagingResponse({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ProductPagingResponse.fromJson(Map<String, dynamic> json) => _$ProductPagingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductPagingResponseToJson(this);
}
