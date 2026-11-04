import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/features/category/domain/entity/category_entity.dart';
import 'package:ecommerce_app/features/category/presentation/view_model/cubit/category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryItem extends StatelessWidget {
  final CategoryEntity category;
  const CategoryItem(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    bool isSelected = context.select((CategoryCubit cubit) => cubit.state.selectedCategory == category);

    // Handle item click by calling onItemClick callback
    return InkWell(
      onTap: () => context.read<CategoryCubit>().selectCategory(category),
      child: Container(
        // Set background color based on selection
        color: isSelected ? ColorManager.white : Colors.transparent,
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Row(
          children: [
            //Show/hide the indicator based on selection
            Visibility(
              visible: isSelected,
              child: Container(
                width: AppSize.s8,
                height: AppSize.s60,
                decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.circular(AppSize.s100),
                ),
              ),
            ),
            // wrap the text with expanded to avoid overflow error
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p16, horizontal: AppPadding.p8),
              child: Text(
                category.name ?? '',
                textAlign: TextAlign.start,
                style: getMediumStyle(color: ColorManager.primary, fontSize: FontSize.s14),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
