import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/di/di.dart';
import 'package:ecommerce_app/core/resources/constants_manager.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio get dio {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        headers: {"token": getIt<SharedPreferences>().getString(AppConstants.tokenKey)},
      ),
    );
    dio.interceptors.add(LogDioInterceptor());

    return dio;
  }
}

class LogDioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    log("========REQUEST=======");
    log('url:${options.uri.path}');
    log('data:${options.data}');
    log('queryParameters:${options.queryParameters}');
    log('headers:${options.headers}');
    log("========REQUEST END=======");
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    RequestOptions options = response.requestOptions;

    super.onResponse(response, handler);
    log("========RESPONSE=======");
    log('statusCode:${response.statusCode}');
    log('url:${options.path}');
    log('data:${response.data}');
    log('statusMessage:${response.statusMessage}');
    log("========RESPONSE END=======");
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }
}
