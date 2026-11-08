import 'package:ecommerce_app/core/network/models/response_model.dart';
import 'package:ecommerce_app/features/cart/domain/entity/cart_entity.dart';
import 'package:ecommerce_app/features/cart/domain/repository/cart_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateCartItemUsecase {
  final CartRepo _cartRepo;

  UpdateCartItemUsecase({required CartRepo cartRepo}) : _cartRepo = cartRepo;

  /// Sets the number of units of [productId] in the cart to [count].
  Future<Response<CartEntity>> call(String productId, int count) async =>
      await _cartRepo.updateCartItem(productId, count);
}
