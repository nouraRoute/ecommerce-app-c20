import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/network/endpoints.dart';
import 'package:ecommerce_app/features/products/data/model/response_models/get_products_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'products_api.g.dart';

@injectable
@RestApi()
abstract class ProductsApi {
  @factoryMethod
  factory ProductsApi(Dio dio) = _ProductsApi;

  /// Null parameters are dropped from the query string by the generated client.
  @GET(Endpoints.getProductsEndpoint)
  Future<GetProductsResponseModel> getProducts({
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('sort') String? sort,
    @Query('fields') String? fields,
    @Query('keyword') String? keyword,
    @Query('brand') String? brand,
    @Query('price[gte]') num? priceGte,
    @Query('price[lte]') num? priceLte,
    @Query('category[in]') List<String>? categoryIn,
  });
}
