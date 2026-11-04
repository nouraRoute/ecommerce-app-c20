import 'package:ecommerce_app/core/network/models/response_model.dart';
import 'package:ecommerce_app/features/products/domain/entity/product_entity.dart';
import 'package:ecommerce_app/features/products/domain/entity/products_params_entity.dart';
import 'package:ecommerce_app/features/products/domain/repository/products_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductsUsecase {
  final ProductsRepo _productsRepo;

  GetProductsUsecase({required ProductsRepo productsRepo}) : _productsRepo = productsRepo;

  /// Call with no argument to fetch the first page unfiltered.
  Future<Response<List<ProductEntity>>> call([ProductsParamsEntity params = const ProductsParamsEntity()]) async =>
      await _productsRepo.getProducts(params);
}
