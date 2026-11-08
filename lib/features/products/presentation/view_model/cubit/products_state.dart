part of 'products_cubit.dart';

class ProductsState extends Equatable {
  final SharedStatusModel<List<ProductEntity>>? productsStatus;
  final ProductsParamsEntity productsParamsEntity;
  const ProductsState._({this.productsStatus, required this.productsParamsEntity});
  const ProductsState.initial({this.productsStatus}) : productsParamsEntity = const ProductsParamsEntity();

  copyWith({SharedStatusModel<List<ProductEntity>>? productsStatus, ProductsParamsEntity? productsParamsEntity}) {
    return ProductsState._(
      productsStatus: productsStatus ?? this.productsStatus,
      productsParamsEntity: productsParamsEntity ?? this.productsParamsEntity,
    );
  }

  @override
  List<Object?> get props => [productsStatus, productsParamsEntity];
}
