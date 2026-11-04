// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metadata_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetadataResponseModel _$MetadataResponseModelFromJson(
        Map<String, dynamic> json) =>
    MetadataResponseModel(
      currentPage: (json['currentPage'] as num?)?.toInt(),
      numberOfPages: (json['numberOfPages'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
      nextPage: (json['nextPage'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MetadataResponseModelToJson(
        MetadataResponseModel instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'numberOfPages': instance.numberOfPages,
      'limit': instance.limit,
      'nextPage': instance.nextPage,
    };
