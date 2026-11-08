import 'package:ecommerce_app/core/di/di.dart';
import 'package:ecommerce_app/core/models/shared_status_model/shared_status_model.dart';
import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/features/cart/domain/entity/cart_entity.dart';
import 'package:ecommerce_app/features/cart/presentation/view/widgets/cart_item_widget.dart';
import 'package:ecommerce_app/features/cart/presentation/view/widgets/total_price_and_checkout_botton.dart';
import 'package:ecommerce_app/features/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<CartCubit>()..getCart(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cart', style: getMediumStyle(fontSize: 20, color: ColorManager.textColor)),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: ImageIcon(AssetImage(IconsAssets.icSearch), color: ColorManager.primary),
            ),
            BlocProvider.value(
              value: getIt<CartCubit>(),
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  return Badge.count(
                    padding: const EdgeInsets.all(0),
                    alignment: const Alignment(.5, -.7),
                    isLabelVisible: (state.carCount ?? 0) != 0,
                    count: state.carCount ?? 0,
                    child: IconButton(
                      onPressed: () {},
                      icon: ImageIcon(AssetImage(IconsAssets.icCart), color: ColorManager.primary),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            switch (state.cartStatus) {
              case null:
              case LoadingState<CartEntity>():
                return const Center(child: CircularProgressIndicator());

              case ErrorState<CartEntity>():
                return Center(child: Text((state.cartStatus as ErrorState).errorMessage));
              case SuccessState<CartEntity>():
                CartEntity cartEntity = (state.cartStatus as SuccessState<CartEntity>).data;
                return Padding(
                  padding: const EdgeInsets.all(AppPadding.p14),
                  child: Column(
                    children: [
                      Expanded(
                        // the list of cart items ===============
                        child: ListView.separated(
                          itemBuilder: (context, index) => CartItemWidget(cartItemEntity: cartEntity.items[index]),
                          separatorBuilder: (context, index) => SizedBox(height: AppSize.s12.h),
                          itemCount: cartEntity.numOfCartItems ?? 0,
                        ),
                      ),
                      // the total price and checkout button========
                      TotalPriceAndCheckoutBotton(totalPrice: 1200, checkoutButtonOnTap: () {}),
                      SizedBox(height: 10.h),
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
