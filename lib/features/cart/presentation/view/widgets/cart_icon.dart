import 'package:ecommerce_app/core/di/di.dart';
import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/routes_manager/routes.dart';
import 'package:ecommerce_app/features/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key, required this.isClickable});
  final bool isClickable;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<CartCubit>(),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return Badge.count(
            padding: const EdgeInsets.all(0),
            alignment: const Alignment(.5, -.7),
            isLabelVisible: (state.carCount ?? 0) != 0,
            count: state.carCount ?? 0,
            child: IconButton(
              onPressed: isClickable ? () => Navigator.pushNamed(context, Routes.cartRoute) : null,
              icon: ImageIcon(AssetImage(IconsAssets.icCart), color: ColorManager.primary),
            ),
          );
        },
      ),
    );
  }
}
