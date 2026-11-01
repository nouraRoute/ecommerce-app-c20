import 'package:ecommerce_app/core/network/models/response_model.dart';
import 'package:ecommerce_app/features/auth/domain/entity/user_entity.dart';
import 'package:ecommerce_app/features/auth/domain/repository/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUsecase {
  final AuthRepo _authRepo;

  RegisterUsecase({required AuthRepo authRepo}) : _authRepo = authRepo;
  Future<Response<UserEntity?>> call(UserEntity user) async => await _authRepo.register(user);
}
