part of 'cart_cubit.dart';

class CartState extends Equatable {
  final SharedStatusModel<CartEntity>? cartStatus;
  const CartState({this.cartStatus});
  int? get carCount =>
      cartStatus is SuccessState<CartEntity> ? (cartStatus as SuccessState<CartEntity>).data.numOfCartItems : null;
  @override
  List<Object?> get props => [cartStatus];
  copWith({SharedStatusModel<CartEntity>? cartStatus}) {
    return CartState(cartStatus: cartStatus ?? this.cartStatus);
  }
}
