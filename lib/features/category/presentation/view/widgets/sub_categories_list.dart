import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/features/category/presentation/view/widgets/category_card_item.dart';
import 'package:ecommerce_app/features/category/presentation/view_model/cubit/category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sub_category_item.dart';

class SubCategoriesList extends StatelessWidget {
  const SubCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
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
            if ((state.subCategories ?? []).isEmpty) {
              return const Center(
                child: Text("No SubCategories Found"),
              );
            } else {
              return CustomScrollView(
                slivers: <Widget>[
                  // category title
                  SliverToBoxAdapter(
                    child: Text(
                      'Laptops & Electronics',
                      style: getBoldStyle(color: ColorManager.primary, fontSize: FontSize.s14),
                    ),
                  ),
                  // the category card
                  SliverToBoxAdapter(
                    child: CategoryCardItem("Laptops & Electronics", ImageAssets.categoryCardImage),
                  ),
                  // the grid view of the subcategories
                  SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        childCount: state.subCategories!.length,
                        (context, index) =>
                            SubCategoryItem(state.subCategories![index].name ?? '', ImageAssets.categoryCardImage),
                      ),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.75,
                        mainAxisSpacing: AppSize.s8,
                        crossAxisSpacing: AppSize.s8,
                      ))
                ],
              );
            }
          }
        },
      ),
    );
  }

  goToCategoryProductsListScreen() {
    // todo implement this function
  }
}
