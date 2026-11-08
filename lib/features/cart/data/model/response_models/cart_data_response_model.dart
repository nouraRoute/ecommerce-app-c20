import 'package:ecommerce_app/features/cart/data/model/response_models/cart_item_response_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cart_data_response_model.g.dart';

/// The `data` object of every cart response. For an empty cart only `products` and `totalCartPrice` are present.
@JsonSerializable()
class CartDataResponseModel {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'cartOwner')
  String? cartOwner;
  @JsonKey(name: 'products')
  List<CartItemResponseModel>? products;
  @JsonKey(name: 'totalCartPrice')
  num? totalCartPrice;
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;

  CartDataResponseModel({
    this.id,
    this.cartOwner,
    this.products,
    this.totalCartPrice,
    this.createdAt,
    this.updatedAt,
  });

  factory CartDataResponseModel.fromJson(Map<String, dynamic> json) => _$CartDataResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartDataResponseModelToJson(this);
}
