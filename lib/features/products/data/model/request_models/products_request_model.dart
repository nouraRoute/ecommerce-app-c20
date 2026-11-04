import 'package:ecommerce_app/features/products/domain/entity/products_params_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'products_request_model.g.dart';

/// Query parameters of `GET /products`, sent through Retrofit's `@Queries()` via [toJson].
@JsonSerializable()
class ProductsRequestModel {
  @JsonKey(name: 'limit')
  final int? limit;
  @JsonKey(name: 'page')
  final int? page;
  @JsonKey(name: 'sort')
  final String? sort;
  @JsonKey(name: 'fields')
  final String? fields;
  @JsonKey(name: 'keyword')
  final String? keyword;
  @JsonKey(name: 'brand')
  final String? brand;
  @JsonKey(name: 'price[gte]')
  final num? priceGte;
  @JsonKey(name: 'price[lte]')
  final num? priceLte;
  @JsonKey(name: 'category[in]')
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
