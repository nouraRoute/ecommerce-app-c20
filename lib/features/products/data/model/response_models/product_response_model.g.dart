// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResponseModel _$ProductResponseModelFromJson(
  Map<String, dynamic> json,
) => ProductResponseModel(
  id: json['_id'] as String?,
  title: json['title'] as String?,
  slug: json['slug'] as String?,
  description: json['description'] as String?,
  imageCover: json['imageCover'] as String?,
  images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
  price: json['price'] as num?,
  quantity: (json['quantity'] as num?)?.toInt(),
  sold: (json['sold'] as num?)?.toInt(),
  ratingsAverage: json['ratingsAverage'] as num?,
  ratingsQuantity: (json['ratingsQuantity'] as num?)?.toInt(),
  category: json['category'] == null
      ? null
      : CategoryResponseModel.fromJson(
          json['category'] as Map<String, dynamic>,
        ),
  subcategory: (json['subcategory'] as List<dynamic>?)
      ?.map((e) => SubcategoryResponseModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  brand: json['brand'] == null
      ? null
      : BrandResponseModel.fromJson(json['brand'] as Map<String, dynamic>),
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$ProductResponseModelToJson(
  ProductResponseModel instance,
) => <String, dynamic>{
  '_id': instance.id,
  'title': instance.title,
  'slug': instance.slug,
  'description': instance.description,
  'imageCover': instance.imageCover,
  'images': instance.images,
  'price': instance.price,
  'quantity': instance.quantity,
  'sold': instance.sold,
  'ratingsAverage': instance.ratingsAverage,
  'ratingsQuantity': instance.ratingsQuantity,
  'category': instance.category,
  'subcategory': instance.subcategory,
  'brand': instance.brand,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
