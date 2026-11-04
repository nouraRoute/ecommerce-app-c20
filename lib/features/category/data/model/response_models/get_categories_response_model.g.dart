// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_categories_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCategoriesResponseModel _$GetCategoriesResponseModelFromJson(
        Map<String, dynamic> json) =>
    GetCategoriesResponseModel(
      results: (json['results'] as num?)?.toInt(),
      metadata: json['metadata'] == null
          ? null
          : MetadataResponseModel.fromJson(
              json['metadata'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => CategoryResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetCategoriesResponseModelToJson(
        GetCategoriesResponseModel instance) =>
    <String, dynamic>{
      'results': instance.results,
      'metadata': instance.metadata,
      'data': instance.data,
    };
