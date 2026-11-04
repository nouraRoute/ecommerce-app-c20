import 'package:ecommerce_app/features/products/data/api/products_api.dart';
import 'package:ecommerce_app/features/products/data/model/response_models/get_products_response_model.dart';
import 'package:injectable/injectable.dart';

abstract class ProductsDataSource {
  Future<GetProductsResponseModel> getProducts({
    int? limit,
    int? page,
    String? sort,
    String? fields,
    String? keyword,
    String? brand,
    num? priceGte,
    num? priceLte,
    List<String>? categoryIn,
  });
}

@Injectable(as: ProductsDataSource)
class ProductsRemoteDataSource implements ProductsDataSource {
  final ProductsApi _productsApi;

  ProductsRemoteDataSource({required ProductsApi productsApi}) : _productsApi = productsApi;

  @override
  Future<GetProductsResponseModel> getProducts({
    int? limit,
    int? page,
    String? sort,
    String? fields,
    String? keyword,
    String? brand,
    num? priceGte,
    num? priceLte,
    List<String>? categoryIn,
  }) async =>
      await _productsApi.getProducts(
        limit: limit,
        page: page,
        sort: sort,
        fields: fields,
        keyword: keyword,
        brand: brand,
        priceGte: priceGte,
        priceLte: priceLte,
        categoryIn: categoryIn,
      );
}
