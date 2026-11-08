import 'package:ecommerce_app/core/di/di.dart';
import 'package:ecommerce_app/core/models/shared_status_model/shared_status_model.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/features/products/domain/entity/product_entity.dart';
import 'package:ecommerce_app/features/products/domain/entity/products_params_entity.dart';
import 'package:ecommerce_app/features/products/presentation/view_model/cubit/products_cubit.dart';
import 'package:ecommerce_app/features/products_screen/presentation/widgets/custom_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/widget/home_screen_app_bar.dart';

class ProductsScreen extends StatelessWidget {
  final List<String>? categoriesId;
  const ProductsScreen({super.key, this.categoriesId});

  @override
  Widget build(BuildContext context) {
    print("---->${categoriesId}");
    return BlocProvider(
      create: (context) => getIt<ProductsCubit>()
        ..editProductsParams(ProductsParamsEntity(categoryIn: categoriesId == null ? null : categoriesId))
        ..getProducts(),
      child: Scaffold(
        appBar: const HomeScreenAppBar(automaticallyImplyLeading: true),
        body: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            switch (state.productsStatus) {
              case null:
              case LoadingState<List<ProductEntity>>():
                return const Center(child: CircularProgressIndicator());
              case ErrorState<List<ProductEntity>>():
                return Center(child: Text((state.productsStatus as ErrorState).errorMessage));
              case SuccessState<List<ProductEntity>>():
                List<ProductEntity> products = (state.productsStatus as SuccessState).data;
                return Padding(
                  padding: const EdgeInsets.all(AppPadding.p16),
                  child: Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          itemCount: products.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 7 / 9,
                          ),
                          itemBuilder: (context, index) {
                            return CustomProductWidget(productEntity: products[index]);
                          },
                          scrollDirection: Axis.vertical,
                        ),
                      ),
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
