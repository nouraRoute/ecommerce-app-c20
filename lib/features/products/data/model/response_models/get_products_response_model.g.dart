// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_products_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProductsResponseModel _$GetProductsResponseModelFromJson(
  Map<String, dynamic> json,
) => GetProductsResponseModel(
  results: (json['results'] as num?)?.toInt(),
  metadata: json['metadata'] == null
      ? null
      : MetadataResponseModel.fromJson(
          json['metadata'] as Map<String, dynamic>,
        ),
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => ProductResponseModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$GetProductsResponseModelToJson(
  GetProductsResponseModel instance,
) => <String, dynamic>{
  'results': instance.results,
  'metadata': instance.metadata,
  'data': instance.data,
};
