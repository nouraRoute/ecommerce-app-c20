import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/network/endpoints.dart';
import 'package:ecommerce_app/features/cart/data/model/request_models/add_to_cart_request_model.dart';
import 'package:ecommerce_app/features/cart/data/model/request_models/update_cart_item_request_model.dart';
import 'package:ecommerce_app/features/cart/data/model/response_models/cart_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'cart_api.g.dart';

@injectable
@RestApi()
abstract class CartApi {
  @factoryMethod
  factory CartApi(Dio dio) = _CartApi;

  @GET(Endpoints.getCartEndpoint)
  Future<CartResponseModel> getCart();

  @POST(Endpoints.addToCartEndpoint)
  Future<CartResponseModel> addToCart(@Body() AddToCartRequestModel requestModel);

  @PUT(Endpoints.updateCartItemEndpoint)
  Future<CartResponseModel> updateCartItem(
    @Path('id') String productId,
    @Body() UpdateCartItemRequestModel requestModel,
  );

  @DELETE(Endpoints.removeFromCartEndpoint)
  Future<CartResponseModel> removeFromCart(@Path('id') String productId);
}
