import 'package:ecommerce_app/features/products/domain/entity/products_params_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'products_request_model.g.dart';

/// Query parameters of `GET /products`, sent through Retrofit's `@Queries()` via [toJson].
@JsonSerializable()
class ProductsRequestModel {
  @JsonKey(name: 'limit', includeIfNull: false)
  final int? limit;
  @JsonKey(name: 'page', includeIfNull: false)
  final int? page;
  @JsonKey(name: 'sort', includeIfNull: false)
  final String? sort;
  @JsonKey(name: 'fields', includeIfNull: false)
  final String? fields;
  @JsonKey(name: 'keyword', includeIfNull: false)
  final String? keyword;
  @JsonKey(name: 'brand', includeIfNull: false)
  final String? brand;
  @JsonKey(name: 'price[gte]', includeIfNull: false)
  final num? priceGte;
  @JsonKey(name: 'price[lte]', includeIfNull: false)
  final num? priceLte;
  @JsonKey(name: 'category[in]', includeIfNull: false)
  final List<String>? categoryIn;

  ProductsRequestModel({
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

  factory ProductsRequestModel.fromJson(Map<String, dynamic> json) => _$ProductsRequestModelFromJson(json);

  /// Null fields are removed so Dio never sends a bare key (`?limit&page`) for an unset parameter.
  Map<String, dynamic> toJson() => _$ProductsRequestModelToJson(this)..removeWhere((_, value) => value == null);

  static ProductsRequestModel fromDomain(ProductsParamsEntity params) => ProductsRequestModel(
    limit: params.limit,
    page: params.page,
    sort: params.sort,
    fields: params.fields,
    keyword: params.keyword,
    brand: params.brand,
    priceGte: params.priceGte,
    priceLte: params.priceLte,
    categoryIn: params.categoryIn,
  );
}
