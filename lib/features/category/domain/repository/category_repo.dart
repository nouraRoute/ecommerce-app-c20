import 'package:ecommerce_app/core/network/models/response_model.dart';
import 'package:ecommerce_app/features/category/domain/entity/category_entity.dart';

abstract class CategoryRepo {
  Future<Response<List<CategoryEntity>>> getCategories();
  Future<Response<List<CategoryEntity>>> getSubcategories(String id);
}
