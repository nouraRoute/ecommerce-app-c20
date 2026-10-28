import 'package:ecommerce_app/core/error/error_model.dart';

sealed class Response<T> {
  Response();
}

class Success<T> extends Response<T> {
  final T data;

  Success({required this.data});
}

class Failure<T> extends Response<T> {
  final ErrorModel errorModel;

  Failure({required this.errorModel});
}
