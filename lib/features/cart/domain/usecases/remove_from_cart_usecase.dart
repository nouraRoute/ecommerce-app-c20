import 'package:ecommerce_app/core/network/models/response_model.dart';
import 'package:ecommerce_app/features/cart/domain/entity/cart_entity.dart';
import 'package:ecommerce_app/features/cart/domain/repository/cart_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoveFromCartUsecase {
  final CartRepo _cartRepo;

  RemoveFromCartUsecase({required CartRepo cartRepo}) : _cartRepo = cartRepo;

  /// Removes the whole line for [productId], whatever its count.
  Future<Response<CartEntity>> call(String productId) async => await _cartRepo.removeFromCart(productId);
}
