import 'package:ecommerce_app/core/network/models/response_model.dart';
import 'package:ecommerce_app/features/products/domain/entity/product_entity.dart';
import 'package:ecommerce_app/features/products/domain/entity/products_params_entity.dart';

abstract class ProductsRepo {
  Future<Response<List<ProductEntity>>> getProducts(ProductsParamsEntity params);
}
