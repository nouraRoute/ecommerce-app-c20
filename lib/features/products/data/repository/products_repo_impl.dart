import 'package:ecommerce_app/core/error/error_model.dart';
import 'package:ecommerce_app/core/network/models/response_model.dart';
import 'package:ecommerce_app/features/products/data/data_source/products_data_source.dart';
import 'package:ecommerce_app/features/products/data/model/response_models/get_products_response_model.dart';
import 'package:ecommerce_app/features/products/domain/entity/product_entity.dart';
import 'package:ecommerce_app/features/products/domain/entity/products_params_entity.dart';
import 'package:ecommerce_app/features/products/domain/repository/products_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductsRepo)
class ProductsRepoImpl implements ProductsRepo {
  final ProductsDataSource _productsDataSource;

  ProductsRepoImpl({required ProductsDataSource productsDataSource}) : _productsDataSource = productsDataSource;

  @override
  Future<Response<List<ProductEntity>>> getProducts(ProductsParamsEntity params) async {
    try {
      GetProductsResponseModel responseModel = await _productsDataSource.getProducts(
        limit: params.limit,
        page: params.page,
        sort: params.sort,
        fields: params.fields,
        keyword: params.keyword,
        brand: params.brand,
        priceGte: params.priceGte,
        priceLte: params.priceLte,
        categoryIn: params.categoryIn,
      );
      List<ProductEntity> products = responseModel.data?.map((model) => model.toDomain()).toList() ?? [];
      return Success(data: products);
    } catch (e) {
      ErrorModel error = ErrorModel.errorHandler(e);
      return Failure(errorModel: error);
    }
  }
}
