import 'package:ecommerce_app/features/auth/domain/repository/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckLoginUsecase {
  final AuthRepo _authRepo;
  CheckLoginUsecase({required AuthRepo authRepo}) : _authRepo = authRepo;

  bool call() {
    return _authRepo.checkLogin();
  }
}
