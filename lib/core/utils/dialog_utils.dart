import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/routes_manager/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class AppDialogs {
  static successDialog({String? message}) => _showDialog(message: message ?? "Success", lottyPath: LottyAssets.success);
  static errorDialog({String? message}) =>
      _showDialog(message: message ?? "something went wrong", lottyPath: LottyAssets.error);

  static _showDialog({required String message, required String lottyPath}) {
    if (navigatorKey.currentContext == null) return;

    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => Dialog(
        child: Column(
          spacing: 10.h,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            LottieBuilder.asset(
              lottyPath,
              height: 200.h,
              fit: BoxFit.fill,
            ),
            Text(
              message,
              style: getMediumStyle(color: ColorManager.textColor, fontSize: 25.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.h,
            )
          ],
        ),
      ),
    );
  }
}
