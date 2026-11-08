// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_data_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartDataResponseModel _$CartDataResponseModelFromJson(
  Map<String, dynamic> json,
) => CartDataResponseModel(
  id: json['_id'] as String?,
  cartOwner: json['cartOwner'] as String?,
  products: (json['products'] as List<dynamic>?)
      ?.map((e) => CartItemResponseModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalCartPrice: json['totalCartPrice'] as num?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$CartDataResponseModelToJson(
  CartDataResponseModel instance,
) => <String, dynamic>{
  '_id': instance.id,
  'cartOwner': instance.cartOwner,
  'products': instance.products,
  'totalCartPrice': instance.totalCartPrice,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
