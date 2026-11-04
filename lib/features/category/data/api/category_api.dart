import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/network/endpoints.dart';
import 'package:ecommerce_app/features/category/data/model/response_models/get_categories_response_model.dart';
import 'package:ecommerce_app/features/category/data/model/response_models/get_subcategories_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'category_api.g.dart';

@injectable
@RestApi()
abstract class CategoryApi {
  @factoryMethod
  factory CategoryApi(Dio dio) = _CategoryApi;
  @GET(Endpoints.getCategoriesEndpoint)
  Future<GetCategoriesResponseModel> getCategories();
  @GET(Endpoints.getSubcategoriesEndpoint)
  Future<GetSubcategoriesResponseModel> getSubcategories(@Path('id') String id);
}
