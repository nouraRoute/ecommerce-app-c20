import 'package:ecommerce_app/core/error/error_model.dart';
import 'package:ecommerce_app/core/network/models/response_model.dart';
import 'package:ecommerce_app/features/category/data/data_source/category_data_source.dart';
import 'package:ecommerce_app/features/category/data/model/response_models/get_categories_response_model.dart';
import 'package:ecommerce_app/features/category/data/model/response_models/get_subcategories_response_model.dart';
import 'package:ecommerce_app/features/category/domain/entity/category_entity.dart';
import 'package:ecommerce_app/features/category/domain/repository/category_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CategoryRepo)
class CategoryRepoImpl implements CategoryRepo {
  final CategoryDataSource _categoryDataSource;

  CategoryRepoImpl({required CategoryDataSource categoryDataSource}) : _categoryDataSource = categoryDataSource;

  @override
  Future<Response<List<CategoryEntity>>> getCategories() async {
    try {
      GetCategoriesResponseModel responseModel = await _categoryDataSource.getCategories();
      List<CategoryEntity> categories = responseModel.data?.map((model) => model.toDomain()).toList() ?? [];
      return Success(data: categories);
    } catch (e) {
      ErrorModel error = ErrorModel.errorHandler(e);
      return Failure(errorModel: error);
    }
  }

  @override
  Future<Response<List<CategoryEntity>>> getSubcategories(String id) async {
    try {
      GetSubcategoriesResponseModel responseModel = await _categoryDataSource.getSubcategories(id);
      List<CategoryEntity> subcategories = responseModel.data?.map((model) => model.toDomain()).toList() ?? [];
      return Success(data: subcategories);
    } catch (e) {
      ErrorModel error = ErrorModel.errorHandler(e);
      return Failure(errorModel: error);
    }
  }
}
