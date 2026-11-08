import 'package:ecommerce_app/features/products/domain/entity/product_entity.dart';
import 'package:equatable/equatable.dart';

/// One line of the cart: a product and how many units of it are in the cart.
class CartItemEntity extends Equatable {
  /// Id of the cart line itself (not the product id).
  final String? id;

  /// Number of units of [product] in the cart.
  final int? count;

  /// Unit price at the time the product was added.
  final num? price;

  /// After `getCart`, `updateCartItem` and `removeFromCart` this is the full product.
  /// After `addToCart` the server only sends the product id, so just [ProductEntity.id] is set.
  final ProductEntity? product;

  const CartItemEntity({this.id, this.count, this.price, this.product});

  @override
  List<Object?> get props => [id, count, price, product];
}
