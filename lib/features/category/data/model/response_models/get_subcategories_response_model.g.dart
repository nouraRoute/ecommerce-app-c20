// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_subcategories_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSubcategoriesResponseModel _$GetSubcategoriesResponseModelFromJson(
  Map<String, dynamic> json,
) => GetSubcategoriesResponseModel(
  results: (json['results'] as num?)?.toInt(),
  metadata: json['metadata'] == null
      ? null
      : MetadataResponseModel.fromJson(
          json['metadata'] as Map<String, dynamic>,
        ),
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => SubcategoryResponseModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$GetSubcategoriesResponseModelToJson(
  GetSubcategoriesResponseModel instance,
) => <String, dynamic>{
  'results': instance.results,
  'metadata': instance.metadata,
  'data': instance.data,
};
