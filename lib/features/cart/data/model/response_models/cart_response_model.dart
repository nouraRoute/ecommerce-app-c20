import 'package:ecommerce_app/features/cart/data/model/response_models/cart_data_response_model.dart';
import 'package:ecommerce_app/features/cart/domain/entity/cart_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cart_response_model.g.dart';

/// Top-level wrapper shared by `GET /cart`, `POST /cart`, `PUT /cart/{id}` and `DELETE /cart/{id}`.
/// Owns `toDomain()` because the entity flattens `numOfCartItems` (here) with `data.*`.
@JsonSerializable()
class CartResponseModel {
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'numOfCartItems')
  int? numOfCartItems;
  @JsonKey(name: 'cartId')
  String? cartId;
  @JsonKey(name: 'data')
  CartDataResponseModel? data;

  CartResponseModel({this.status, this.message, this.numOfCartItems, this.cartId, this.data});

  factory CartResponseModel.fromJson(Map<String, dynamic> json) => _$CartResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartResponseModelToJson(this);

  CartEntity toDomain() => CartEntity(
        id: data?.id ?? cartId,
        numOfCartItems: numOfCartItems,
        totalCartPrice: data?.totalCartPrice,
        items: data?.products?.map((model) => model.toDomain()).toList() ?? [],
      );
}
