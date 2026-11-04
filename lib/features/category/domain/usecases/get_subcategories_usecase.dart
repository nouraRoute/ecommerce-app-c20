import 'package:ecommerce_app/core/network/models/response_model.dart';
import 'package:ecommerce_app/features/category/domain/entity/category_entity.dart';
import 'package:ecommerce_app/features/category/domain/repository/category_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSubcategoriesUsecase {
  final CategoryRepo _categoryRepo;

  GetSubcategoriesUsecase({required CategoryRepo categoryRepo}) : _categoryRepo = categoryRepo;
  Future<Response<List<CategoryEntity>>> call(String id) async => await _categoryRepo.getSubcategories(id);
}
