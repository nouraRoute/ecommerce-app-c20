import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/models/shared_status_model/shared_status_model.dart';
import 'package:ecommerce_app/core/network/models/response_model.dart';
import 'package:ecommerce_app/features/products/domain/entity/product_entity.dart';
import 'package:ecommerce_app/features/products/domain/entity/products_params_entity.dart';
import 'package:ecommerce_app/features/products/domain/usecases/get_products_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'products_state.dart';

@injectable
class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit({required GetProductsUsecase getProductsUsecase})
      : _getProductsUsecase = getProductsUsecase,
        super(const ProductsState.initial());
  final GetProductsUsecase _getProductsUsecase;

  getProducts() async {
    print("---##->${state.productsParamsEntity.categoryIn}");
    emit(state.copyWith(productsStatus: const LoadingState()));
    final result = await _getProductsUsecase(state.productsParamsEntity);
    switch (result) {
      case Success<List<ProductEntity>>():
        emit(state.copyWith(productsStatus: SuccessState(result.data)));
      case Failure<List<ProductEntity>>():
        emit(state.copyWith(productsStatus: ErrorState(result.errorModel.message)));
    }
  }

  editProductsParams(ProductsParamsEntity productsParamsEntity) {
    emit(state.copyWith(productsParamsEntity: productsParamsEntity));
  }
}
