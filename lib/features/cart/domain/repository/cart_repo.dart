import 'package:ecommerce_app/core/network/models/response_model.dart';
import 'package:ecommerce_app/features/cart/domain/entity/cart_entity.dart';

/// Every method returns the cart as it is after the call.
abstract class CartRepo {
  Future<Response<CartEntity>> getCart();
  Future<Response<CartEntity>> addToCart(String productId);
  Future<Response<CartEntity>> updateCartItem(String productId, int count);
  Future<Response<CartEntity>> removeFromCart(String productId);
}
