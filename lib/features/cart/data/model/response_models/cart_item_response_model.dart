import 'package:ecommerce_app/features/cart/domain/entity/cart_item_entity.dart';
import 'package:ecommerce_app/features/products/data/model/response_models/product_response_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cart_item_response_model.g.dart';

/// One entry of `data.products[]` in every cart response.
@JsonSerializable()
class CartItemResponseModel {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'count')
  int? count;
  @JsonKey(name: 'price')
  num? price;

  /// `POST /cart` sends the product as its id string; `GET`, `PUT` and `DELETE` send the populated object.
  @JsonKey(name: 'product', fromJson: _productFromJson)
  ProductResponseModel? product;

  CartItemResponseModel({this.id, this.count, this.price, this.product});

  factory CartItemResponseModel.fromJson(Map<String, dynamic> json) => _$CartItemResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemResponseModelToJson(this);

  CartItemEntity toDomain() => CartItemEntity(id: id, count: count, price: price, product: product?.toDomain());
}

ProductResponseModel? _productFromJson(Object? json) {
  if (json is Map<String, dynamic>) return ProductResponseModel.fromJson(json);
  if (json is String) return ProductResponseModel(id: json);
  return null;
}
