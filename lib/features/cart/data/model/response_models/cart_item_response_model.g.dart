// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItemResponseModel _$CartItemResponseModelFromJson(
  Map<String, dynamic> json,
) => CartItemResponseModel(
  id: json['_id'] as String?,
  count: (json['count'] as num?)?.toInt(),
  price: json['price'] as num?,
  product: _productFromJson(json['product']),
);

Map<String, dynamic> _$CartItemResponseModelToJson(
  CartItemResponseModel instance,
) => <String, dynamic>{
  '_id': instance.id,
  'count': instance.count,
  'price': instance.price,
  'product': instance.product,
};
