import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/features/category/presentation/view/widgets/categories_list.dart';
import 'package:ecommerce_app/features/category/presentation/view_model/cubit/category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/sub_categories_list.dart';

class CategoriesTab extends StatelessWidget {
  const CategoriesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12, vertical: AppPadding.p12),
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state.isCategoryLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.categoryErrorMessage != null) {
            return Center(
              child: Text(state.categoryErrorMessage!),
            );
          } else {
            if ((state.categories ?? []).isEmpty) {
              return const Center(
                child: Text("No Categories Found"),
              );
            } else {
              return Row(
                children: [
                  CategoriesList(categories: state.categories!),
                  SizedBox(
                    width: AppSize.s16,
                  ),
                  SubCategoriesList()
                ],
              );
            }
          }
        },
      ),
    );
  }
}
