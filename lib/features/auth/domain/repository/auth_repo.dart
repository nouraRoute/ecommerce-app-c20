import 'package:ecommerce_app/core/network/models/response_model.dart';
import 'package:ecommerce_app/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepo {
  Future<Response<UserEntity?>> login(UserEntity user);
  Future<Response<UserEntity?>> register(UserEntity user);
  bool checkLogin();
}
