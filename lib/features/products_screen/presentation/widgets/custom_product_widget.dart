import 'package:ecommerce_app/core/di/di.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/routes_manager/routes.dart';
import 'package:ecommerce_app/core/widget/heart_button.dart';
import 'package:ecommerce_app/features/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/products/domain/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProductWidget extends StatelessWidget {
  final ProductEntity productEntity;

  const CustomProductWidget({super.key, required this.productEntity});

  String truncateTitle(String title) {
    List<String> words = title.split(' ');
    if (words.length <= 2) {
      return title;
    } else {
      return "${words.sublist(0, 2).join(' ')}..";
    }
  }

  String truncateDescription(String description) {
    List<String> words = description.split(RegExp(r'[\s-]+'));
    if (words.length <= 4) {
      return description;
    } else {
      return "${words.sublist(0, 4).join(' ')}..";
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocProvider.value(
      value: getIt<CartCubit>(),
      child: Builder(
        builder: (ctx) {
          bool isInCart = ctx.watch<CartCubit>().isInCart(productEntity.id!);

          return InkWell(
            onTap: () => Navigator.pushNamed(context, Routes.productDetails),
            child: Container(
              width: width * 0.4,
              height: height * 0.3,
              decoration: BoxDecoration(
                border: Border.all(color: ColorManager.primary.withOpacity(0.3), width: 2),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 5,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        // Not working with the lastest flutter version

                        // CachedNetworkImage(
                        //   imageUrl: image,
                        //   height: height * 0.15,
                        //   width: double.infinity,
                        //   fit: BoxFit.cover,
                        //   placeholder: (context, url) =>
                        //       const Center(child: CircularProgressIndicator()),
                        //   errorWidget: (context, url, error) => const Icon(Icons.error),
                        // ),
                        // Image.network(
                        //   image,
                        //   fit: BoxFit.cover,
                        // ),
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(14.r)),
                          child: Image.network(productEntity.imageCover ?? '', fit: BoxFit.cover, width: width),
                        ),
                        Positioned(
                          top: height * 0.005,
                          right: width * 0.02,
                          child: HeartButton(onTap: () {}),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            truncateTitle(productEntity.title ?? ''),
                            style: getMediumStyle(color: ColorManager.textColor, fontSize: 14.sp),
                          ),
                          Text(
                            truncateDescription(productEntity.description ?? ''),
                            style: getRegularStyle(color: ColorManager.textColor, fontSize: 14.sp),
                          ),
                          SizedBox(
                            width: width * 0.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "EGP ${productEntity.price}",
                                  style: getRegularStyle(color: ColorManager.textColor, fontSize: 14.sp),
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(height: height * 0.005),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                // width: width * 0.22,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Review (${productEntity.ratingsQuantity})",
                                      style: getRegularStyle(color: ColorManager.textColor, fontSize: 12.sp),
                                    ),
                                    const Icon(Icons.star_rate_rounded, color: ColorManager.starRateColor),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              if (isInCart)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: InkWell(
                                    onTap: () {
                                      getIt<CartCubit>().removeFromCart(productEntity.id!);
                                    },
                                    child: Container(
                                      height: height * 0.034,
                                      width: width * 0.07,
                                      // decoration: BoxDecoration(shape: BoxShape.circle, color: ),
                                      child: Icon(Icons.delete_outline_outlined, color: ColorManager.error),
                                    ),
                                  ),
                                )
                              else
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: InkWell(
                                    onTap: () {
                                      getIt<CartCubit>().addToCart(productEntity.id!);
                                    },
                                    child: Container(
                                      height: height * 0.034,
                                      width: width * 0.07,
                                      decoration: BoxDecoration(shape: BoxShape.circle, color: ColorManager.primary),
                                      child: const Icon(Icons.add, color: Colors.white),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
