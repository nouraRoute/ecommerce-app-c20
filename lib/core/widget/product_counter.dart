import 'package:ecommerce_app/core/di/di.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/features/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCounter extends StatelessWidget {
  final String productId;
  final int productCounter;
  const ProductCounter({super.key, required this.productCounter, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ColorManager.primary, borderRadius: BorderRadius.circular(24.r)),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.h),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              decrementQuantity();
            },
            child: Icon(Icons.remove_circle_outline, size: 20.w, color: ColorManager.white),
          ),
          SizedBox(width: 18.w),
          Text(
            '$productCounter',
            style: getMediumStyle(color: ColorManager.white).copyWith(fontSize: 18.sp),
          ),
          SizedBox(width: 18.w),
          InkWell(
            onTap: () {
              incrementQuantity();
            },
            child: Icon(Icons.add_circle_outline, color: ColorManager.white, size: 20.w),
          ),
        ],
      ),
    );
  }

  incrementQuantity() {
    getIt<CartCubit>().updateCartCart(productId, productCounter + 1);
  }

  decrementQuantity() {
    getIt<CartCubit>().updateCartCart(productId, productCounter - 1);
  }
}
