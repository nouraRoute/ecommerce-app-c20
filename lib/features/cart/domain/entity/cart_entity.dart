import 'package:ecommerce_app/features/cart/domain/entity/cart_item_entity.dart';
import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  /// Cart id, needed later for checkout. Null while the cart is empty.
  final String? id;

  /// Number of lines in the cart (not the sum of [CartItemEntity.count]).
  final int? numOfCartItems;

  final num? totalCartPrice;

  final List<CartItemEntity> items;

  const CartEntity({this.id, this.numOfCartItems, this.totalCartPrice, this.items = const []});

  @override
  List<Object?> get props => [id, numOfCartItems, totalCartPrice, items];
}
