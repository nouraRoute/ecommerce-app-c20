part of 'cart_cubit.dart';

class CartState extends Equatable {
  final SharedStatusModel<void>? cartUpdateStatus;
  final SharedStatusModel<CartEntity>? cartStatus;
  final CartEntity? cartEntity;
  const CartState({this.cartStatus, this.cartUpdateStatus, this.cartEntity});
  int? get carCount => (cartEntity?.items ?? []).length;
  @override
  List<Object?> get props => [cartStatus, cartUpdateStatus, cartEntity];
  copWith({
    SharedStatusModel<CartEntity>? cartStatus,
    SharedStatusModel<void>? cartUpdateStatus,
    CartEntity? cartEntity,
  }) {
    return CartState(
      cartEntity: cartEntity ?? this.cartEntity,
      cartStatus: cartStatus ?? this.cartStatus,
      cartUpdateStatus: cartUpdateStatus ?? this.cartUpdateStatus,
    );
  }
}
