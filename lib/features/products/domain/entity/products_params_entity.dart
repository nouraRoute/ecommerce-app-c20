import 'package:equatable/equatable.dart';

/// Query parameters of `GET /products`. Every field is optional; a null field is not sent.
class ProductsParamsEntity extends Equatable {
  /// Page size, e.g. `limit=2`.
  final int? limit;

  /// Page number (1-based), e.g. `page=2`.
  final int? page;

  /// Sort expression, prefix with `-` for descending, e.g. `sort=-price`.
  final String? sort;

  /// Comma-separated response fields, e.g. `fields=title,price`.
  final String? fields;

  /// Free-text search, e.g. `keyword=new`.
  final String? keyword;

  /// Brand id, e.g. `brand=6212b6b488f2cee15c5db3c8`.
  final String? brand;

  /// Minimum price (inclusive), sent as `price[gte]`.
  final num? priceGte;

  /// Maximum price (inclusive), sent as `price[lte]`.
  final num? priceLte;

  /// Category ids, sent as one `category[in]` entry per id.
  final List<String>? categoryIn;

  const ProductsParamsEntity({
    this.limit,
    this.page,
    this.sort,
    this.fields,
    this.keyword,
    this.brand,
    this.priceGte,
    this.priceLte,
    this.categoryIn,
  });

  ProductsParamsEntity copyWith({
    int? limit,
    int? page,
    String? sort,
    String? fields,
    String? keyword,
    String? brand,
    num? priceGte,
    num? priceLte,
    List<String>? categoryIn,
  }) =>
      ProductsParamsEntity(
        limit: limit ?? this.limit,
        page: page ?? this.page,
        sort: sort ?? this.sort,
        fields: fields ?? this.fields,
        keyword: keyword ?? this.keyword,
        brand: brand ?? this.brand,
        priceGte: priceGte ?? this.priceGte,
        priceLte: priceLte ?? this.priceLte,
        categoryIn: categoryIn ?? this.categoryIn,
      );

  @override
  List<Object?> get props => [limit, page, sort, fields, keyword, brand, priceGte, priceLte, categoryIn];
}
