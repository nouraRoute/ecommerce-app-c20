import 'package:ecommerce_app/features/cart/data/api/cart_api.dart';
import 'package:ecommerce_app/features/cart/data/model/request_models/add_to_cart_request_model.dart';
import 'package:ecommerce_app/features/cart/data/model/request_models/update_cart_item_request_model.dart';
import 'package:ecommerce_app/features/cart/data/model/response_models/cart_response_model.dart';
import 'package:injectable/injectable.dart';

abstract class CartDataSource {
  Future<CartResponseModel> getCart();
  Future<CartResponseModel> addToCart(AddToCartRequestModel requestModel);
  Future<CartResponseModel> updateCartItem(String productId, UpdateCartItemRequestModel requestModel);
  Future<CartResponseModel> removeFromCart(String productId);
}

@Injectable(as: CartDataSource)
class CartRemoteDataSource implements CartDataSource {
  final CartApi _cartApi;

  CartRemoteDataSource({required CartApi cartApi}) : _cartApi = cartApi;

  @override
  Future<CartResponseModel> getCart() async => await _cartApi.getCart();

  @override
  Future<CartResponseModel> addToCart(AddToCartRequestModel requestModel) async =>
      await _cartApi.addToCart(requestModel);

  @override
  Future<CartResponseModel> updateCartItem(String productId, UpdateCartItemRequestModel requestModel) async =>
      await _cartApi.updateCartItem(productId, requestModel);

  @override
  Future<CartResponseModel> removeFromCart(String productId) async => await _cartApi.removeFromCart(productId);
}
