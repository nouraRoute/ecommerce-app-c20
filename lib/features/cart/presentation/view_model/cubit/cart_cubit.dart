import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/models/shared_status_model/shared_status_model.dart';
import 'package:ecommerce_app/core/network/models/response_model.dart';
import 'package:ecommerce_app/features/cart/domain/entity/cart_entity.dart';
import 'package:ecommerce_app/features/cart/domain/entity/cart_item_entity.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/get_cart_usecase.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/remove_from_cart_usecase.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/update_cart_item_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'cart_state.dart';

@lazySingleton
class CartCubit extends Cubit<CartState> {
  final GetCartUsecase _getCartUsecase;
  final AddToCartUsecase _addToCartUsecase;
  final RemoveFromCartUsecase _removeFromCartUsecase;
  final UpdateCartItemUsecase _updateCartItemUsecase;
  CartCubit({
    required GetCartUsecase getCartUsecase,
    required AddToCartUsecase addToCartUsecase,
    required RemoveFromCartUsecase removeFromCartUsecase,
    required UpdateCartItemUsecase updateCartItemUsecase,
  }) : _getCartUsecase = getCartUsecase,
       _addToCartUsecase = addToCartUsecase,
       _removeFromCartUsecase = removeFromCartUsecase,
       _updateCartItemUsecase = updateCartItemUsecase,
       super(const CartState());

  getCart() async {
    emit(state.copWith(cartStatus: const LoadingState()));
    final result = await _getCartUsecase();
    switch (result) {
      case Success<CartEntity>():
        emit(state.copWith(cartStatus: SuccessState(result.data), cartEntity: result.data));
      case Failure<CartEntity>():
        emit(state.copWith(cartStatus: ErrorState(result.errorModel.message)));
    }
  }

  addToCart(String productId) async {
    emit(state.copWith(cartUpdateStatus: const LoadingState()));
    final result = await _addToCartUsecase(productId);
    switch (result) {
      case Success<CartEntity>():
        emit(state.copWith(cartUpdateStatus: const SuccessState(NoParams())));
        await getCart();

      case Failure<CartEntity>():
        emit(state.copWith(cartUpdateStatus: ErrorState(result.errorModel.message)));
    }
  }

  removeFromCart(String productId) async {
    emit(state.copWith(cartUpdateStatus: const LoadingState()));
    final result = await _removeFromCartUsecase(productId);
    switch (result) {
      case Success<CartEntity>():
        emit(state.copWith(cartUpdateStatus: const SuccessState(NoParams())));
        await getCart();

      case Failure<CartEntity>():
        emit(state.copWith(cartUpdateStatus: ErrorState(result.errorModel.message)));
    }
  }

  updateCartCart(String productId, int quantity) async {
    emit(state.copWith(cartUpdateStatus: const LoadingState()));
    final result = await _updateCartItemUsecase(productId, quantity);
    switch (result) {
      case Success<CartEntity>():
        emit(state.copWith(cartUpdateStatus: const SuccessState(NoParams())));
        await getCart();

      case Failure<CartEntity>():
        emit(state.copWith(cartUpdateStatus: ErrorState(result.errorModel.message)));
    }
  }

  bool isInCart(String productId) =>
      (state.cartEntity?.items ?? []).indexWhere((element) => element.product?.id == productId) != -1;
}
