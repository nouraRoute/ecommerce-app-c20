// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subcategory_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubcategoryResponseModel _$SubcategoryResponseModelFromJson(
  Map<String, dynamic> json,
) => SubcategoryResponseModel(
  id: json['_id'] as String?,
  name: json['name'] as String?,
  slug: json['slug'] as String?,
  category: json['category'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$SubcategoryResponseModelToJson(
  SubcategoryResponseModel instance,
) => <String, dynamic>{
  '_id': instance.id,
  'name': instance.name,
  'slug': instance.slug,
  'category': instance.category,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
