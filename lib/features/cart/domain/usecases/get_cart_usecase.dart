import 'package:ecommerce_app/core/network/models/response_model.dart';
import 'package:ecommerce_app/features/cart/domain/entity/cart_entity.dart';
import 'package:ecommerce_app/features/cart/domain/repository/cart_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCartUsecase {
  final CartRepo _cartRepo;

  GetCartUsecase({required CartRepo cartRepo}) : _cartRepo = cartRepo;

  Future<Response<CartEntity>> call() async => await _cartRepo.getCart();
}
