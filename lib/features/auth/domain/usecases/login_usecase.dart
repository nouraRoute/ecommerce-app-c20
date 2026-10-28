import 'package:ecommerce_app/core/network/models/response_model.dart';
import 'package:ecommerce_app/features/auth/domain/entity/user_entity.dart';
import 'package:ecommerce_app/features/auth/domain/repository/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUsecase {
  final AuthRepo _authRepo;

  LoginUsecase({required AuthRepo authRepo}) : _authRepo = authRepo;
  Future<Response<UserEntity?>> call(UserEntity user) async => await _authRepo.login(user);
}
