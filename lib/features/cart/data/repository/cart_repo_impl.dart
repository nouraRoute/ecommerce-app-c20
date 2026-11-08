import 'package:ecommerce_app/core/error/error_model.dart';
import 'package:ecommerce_app/core/network/models/response_model.dart';
import 'package:ecommerce_app/features/cart/data/data_source/cart_data_source.dart';
import 'package:ecommerce_app/features/cart/data/model/request_models/add_to_cart_request_model.dart';
import 'package:ecommerce_app/features/cart/data/model/request_models/update_cart_item_request_model.dart';
import 'package:ecommerce_app/features/cart/data/model/response_models/cart_response_model.dart';
import 'package:ecommerce_app/features/cart/domain/entity/cart_entity.dart';
import 'package:ecommerce_app/features/cart/domain/repository/cart_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRepo)
class CartRepoImpl implements CartRepo {
  final CartDataSource _cartDataSource;

  CartRepoImpl({required CartDataSource cartDataSource}) : _cartDataSource = cartDataSource;

  @override
  Future<Response<CartEntity>> getCart() async {
    try {
      CartResponseModel responseModel = await _cartDataSource.getCart();
      return Success(data: responseModel.toDomain());
    } catch (e) {
      ErrorModel error = ErrorModel.errorHandler(e);
      return Failure(errorModel: error);
    }
  }

  @override
  Future<Response<CartEntity>> addToCart(String productId) async {
    try {
      CartResponseModel responseModel = await _cartDataSource.addToCart(AddToCartRequestModel.fromDomain(productId));
      return Success(data: responseModel.toDomain());
    } catch (e) {
      ErrorModel error = ErrorModel.errorHandler(e);
      return Failure(errorModel: error);
    }
  }

  @override
  Future<Response<CartEntity>> updateCartItem(String productId, int count) async {
    try {
      CartResponseModel responseModel = await _cartDataSource.updateCartItem(
        productId,
        UpdateCartItemRequestModel.fromDomain(count),
      );
      return Success(data: responseModel.toDomain());
    } catch (e) {
      ErrorModel error = ErrorModel.errorHandler(e);
      return Failure(errorModel: error);
    }
  }

  @override
  Future<Response<CartEntity>> removeFromCart(String productId) async {
    try {
      CartResponseModel responseModel = await _cartDataSource.removeFromCart(productId);
      return Success(data: responseModel.toDomain());
    } catch (e) {
      ErrorModel error = ErrorModel.errorHandler(e);
      return Failure(errorModel: error);
    }
  }
}
