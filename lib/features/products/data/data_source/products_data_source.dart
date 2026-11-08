import 'package:ecommerce_app/features/products/data/api/products_api.dart';
import 'package:ecommerce_app/features/products/data/model/request_models/products_request_model.dart';
import 'package:ecommerce_app/features/products/data/model/response_models/get_products_response_model.dart';
import 'package:injectable/injectable.dart';

abstract class ProductsDataSource {
  Future<GetProductsResponseModel> getProducts(ProductsRequestModel requestModel);
}

@Injectable(as: ProductsDataSource)
class ProductsRemoteDataSource implements ProductsDataSource {
  final ProductsApi _productsApi;

  ProductsRemoteDataSource({required ProductsApi productsApi}) : _productsApi = productsApi;

  @override
  Future<GetProductsResponseModel> getProducts(ProductsRequestModel requestModel) async {
    return await _productsApi.getProducts(requestModel);
  }
}
