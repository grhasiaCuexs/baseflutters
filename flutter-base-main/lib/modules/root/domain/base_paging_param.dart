class PagingParam {
  final int page;
  final int size;
  final String q;

  PagingParam(this.page, this.size, {this.q = ""});

  PagingParam copyWith({
    int? page,
    int? size,
    String? q,
  }) {
    return PagingParam(page ?? this.page, size ?? this.size, q: q ?? this.q);
  }
}
