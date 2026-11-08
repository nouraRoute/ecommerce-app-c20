import 'package:ecommerce_app/core/network/models/response_model.dart';
import 'package:ecommerce_app/features/cart/domain/entity/cart_entity.dart';
import 'package:ecommerce_app/features/cart/domain/repository/cart_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddToCartUsecase {
  final CartRepo _cartRepo;

  AddToCartUsecase({required CartRepo cartRepo}) : _cartRepo = cartRepo;

  /// Adds one unit of [productId]; calling it again for the same product increments its count.
  Future<Response<CartEntity>> call(String productId) async => await _cartRepo.addToCart(productId);
}
