import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/network/endpoints.dart';
import 'package:ecommerce_app/features/products/data/model/request_models/products_request_model.dart';
import 'package:ecommerce_app/features/products/data/model/response_models/get_products_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'products_api.g.dart';

@injectable
@RestApi()
abstract class ProductsApi {
  @factoryMethod
  factory ProductsApi(Dio dio) = _ProductsApi;

  @GET(Endpoints.getProductsEndpoint)
  Future<GetProductsResponseModel> getProducts(@Queries() ProductsRequestModel requestModel);
}
