import 'dart:developer';

import 'package:dio/dio.dart';

sealed class ErrorModel {
  final String message;
  final int? errorCode;

  ErrorModel({required this.message, this.errorCode});
  static ErrorModel errorHandler(Object error) {
    log('ERROR---->${error.toString()}');
    if (error is DioException) {
      return _handleDioError(error);
    } else {
      return TypeParseError(errorMessage: error.toString());
    }
  }

  static ErrorModel _handleDioError(DioException e) {
    String? customErrorMessage = e.response?.data['message'];
    if (customErrorMessage != null) {
      return RequestError(errorMEssage: customErrorMessage);
    }
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return NetworkError();
      case DioExceptionType.badResponse:
        // Extract specific status codes
        final statusCode = e.response?.statusCode;
        if (statusCode == 401 || statusCode == 400) {
          return AuthError(errorMessage: e.response?.data['message'] ?? '');
        } else if (statusCode == 404) {
          return RequestError();
        } else {
          return ServerError();
        }

      case DioExceptionType.cancel:
        return GeneralError();
      default:
        return GeneralError();
    }
  }
}

class GeneralError extends ErrorModel {
  GeneralError({String? errorMessage, super.errorCode}) : super(message: errorMessage ?? 'something went wrong!!');
}

class AuthError extends ErrorModel {
  AuthError({String? errorMessage, super.errorCode}) : super(message: errorMessage ?? 'auth error!!');
}

class TypeParseError extends ErrorModel {
  TypeParseError({String? errorMessage, super.errorCode}) : super(message: errorMessage ?? 'error parsing date!');
}

class NetworkError extends ErrorModel {
  NetworkError() : super(message: "no network connection!!");
}

class RequestError extends ErrorModel {
  RequestError({String? errorMEssage})
      : super(message: errorMEssage ?? "something went wrong while connecting to the sever!");
}

class ServerError extends ErrorModel {
  ServerError() : super(message: "Server error!!");
}
