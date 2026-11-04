// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsRequestModel _$ProductsRequestModelFromJson(
        Map<String, dynamic> json) =>
    ProductsRequestModel(
      limit: (json['limit'] as num?)?.toInt(),
      page: (json['page'] as num?)?.toInt(),
      sort: json['sort'] as String?,
      fields: json['fields'] as String?,
      keyword: json['keyword'] as String?,
      brand: json['brand'] as String?,
      priceGte: json['price[gte]'] as num?,
      priceLte: json['price[lte]'] as num?,
      categoryIn: (json['category[in]'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ProductsRequestModelToJson(
        ProductsRequestModel instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'page': instance.page,
      'sort': instance.sort,
      'fields': instance.fields,
      'keyword': instance.keyword,
      'brand': instance.brand,
      'price[gte]': instance.priceGte,
      'price[lte]': instance.priceLte,
      'category[in]': instance.categoryIn,
    };
