import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/network/models/response_model.dart';
import 'package:ecommerce_app/features/category/domain/entity/category_entity.dart';
import 'package:ecommerce_app/features/category/domain/usecases/get_categories_usecase.dart';
import 'package:ecommerce_app/features/category/domain/usecases/get_subcategories_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'category_state.dart';

@injectable
class CategoryCubit extends Cubit<CategoryState> {
  final GetCategoriesUsecase _getCategoriesUsecase;
  final GetSubcategoriesUsecase _getSubCategoriesUsecase;
  CategoryCubit(
      {required GetCategoriesUsecase getCategoriesUsecase, required GetSubcategoriesUsecase getSubCategoriesUsecase})
      : _getCategoriesUsecase = getCategoriesUsecase,
        _getSubCategoriesUsecase = getSubCategoriesUsecase,
        super(const CategoryState());
  getCategories() async {
    emit(state.copyWith(isCategoryLoading: true, categoryErrorMessage: null));
    Response<List<CategoryEntity>> response = await _getCategoriesUsecase();
    switch (response) {
      case Success<List<CategoryEntity>>():
        emit(state.copyWith(categories: response.data, isCategoryLoading: false));
        if (response.data.isNotEmpty) {
          selectCategory(response.data.first);
        }
        break;
      case Failure<List<CategoryEntity>>():
        emit(state.copyWith(categoryErrorMessage: response.errorModel.message, isCategoryLoading: false));
        break;
    }
  }

  getSubCategories(String categoryId) async {
    emit(state.copyWith(isSubCategoryLoading: true, subCategories: [], subCategoryErrorMessage: null));
    Response<List<CategoryEntity>> response = await _getSubCategoriesUsecase(categoryId);
    switch (response) {
      case Success<List<CategoryEntity>>():
        emit(state.copyWith(subCategories: response.data, isSubCategoryLoading: false));
        break;
      case Failure<List<CategoryEntity>>():
        emit(state.copyWith(subCategoryErrorMessage: response.errorModel.message, isSubCategoryLoading: false));
        break;
    }
  }

  selectCategory(CategoryEntity category) {
    emit(state.copyWith(selectedCategory: category));
    getSubCategories(category.id ?? '');
  }
  // getSubCategories();
}
