import 'package:json_annotation/json_annotation.dart';

part 'paging.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class Paging<T>{
  @JsonKey(name: "current_page")
  final int currentPage;

  @JsonKey(name: "data")
  final T? data;

  @JsonKey(name: "from")
  final int? from;

  @JsonKey(name: "to")
  final int? to;

  @JsonKey(name: "per_page")
  final int perPage;

  @JsonKey(name: "total")
  final int total;

  @JsonKey(name: "last_page")
  final int lastPage;

  @JsonKey(name: "first_page_url")
  final String? firstPageUrl;

  @JsonKey(name: "last_page_url")
  final String? lastPageUrl;

  @JsonKey(name: "next_page_url")
  final String? nextPageUrl;

  @JsonKey(name: "prev_page_url")
  final String? prevPageUrl;

  @JsonKey(name: "path")
  final String path;

  Paging({
    required this.currentPage,
    this.data,
    required this.from,
    required this.to,
    required this.perPage,
    required this.total,
    required this.lastPage,
    this.firstPageUrl,
    this.lastPageUrl,
    this.nextPageUrl,
    this.prevPageUrl,
    required this.path
  });

  factory Paging.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT) => _$PagingFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$PagingToJson<T>(this, toJsonT);
}