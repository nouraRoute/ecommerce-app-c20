part of 'category_cubit.dart';

class CategoryState extends Equatable {
  final bool isCategoryLoading;
  final bool isSubCategoryLoading;
  final String? categoryErrorMessage, subCategoryErrorMessage;
  final List<CategoryEntity>? categories;
  final List<CategoryEntity>? subCategories;
  final CategoryEntity? selectedCategory;
  const CategoryState(
      {this.categories,
      this.subCategories,
      this.selectedCategory,
      this.isCategoryLoading = false,
      this.isSubCategoryLoading = false,
      this.categoryErrorMessage,
      this.subCategoryErrorMessage});
  copyWith(
      {List<CategoryEntity>? categories,
      List<CategoryEntity>? subCategories,
      CategoryEntity? selectedCategory,
      bool? isCategoryLoading,
      bool? isSubCategoryLoading,
      String? categoryErrorMessage,
      String? subCategoryErrorMessage}) {
    return CategoryState(
        categories: categories ?? this.categories,
        subCategories: subCategories ?? this.subCategories,
        isCategoryLoading: isCategoryLoading ?? this.isCategoryLoading,
        isSubCategoryLoading: isSubCategoryLoading ?? this.isSubCategoryLoading,
        categoryErrorMessage: categoryErrorMessage,
        subCategoryErrorMessage: subCategoryErrorMessage,
        selectedCategory: selectedCategory ?? this.selectedCategory);
  }

  @override
  List<Object?> get props => [
        categories,
        subCategories,
        isCategoryLoading,
        isSubCategoryLoading,
        categoryErrorMessage,
        subCategoryErrorMessage,
        selectedCategory
      ];
}
