import 'package:ecommerce_app/features/category/data/api/category_api.dart';
import 'package:ecommerce_app/features/category/data/model/response_models/get_categories_response_model.dart';
import 'package:ecommerce_app/features/category/data/model/response_models/get_subcategories_response_model.dart';
import 'package:injectable/injectable.dart';

abstract class CategoryDataSource {
  Future<GetCategoriesResponseModel> getCategories();
  Future<GetSubcategoriesResponseModel> getSubcategories(String id);
}

@Injectable(as: CategoryDataSource)
class CategoryRemoteDataSource implements CategoryDataSource {
  final CategoryApi _categoryApi;

  CategoryRemoteDataSource({required CategoryApi categoryApi}) : _categoryApi = categoryApi;
  @override
  Future<GetCategoriesResponseModel> getCategories() async => await _categoryApi.getCategories();
  @override
  Future<GetSubcategoriesResponseModel> getSubcategories(String id) async =>
      await _categoryApi.getSubcategories(id);
}
