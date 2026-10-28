import 'package:ecommerce_app/core/error/error_model.dart';
import 'package:ecommerce_app/core/network/models/response_model.dart';
import 'package:ecommerce_app/features/auth/data/data_source/auth_data_source.dart';
import 'package:ecommerce_app/features/auth/data/model/request_models/login_request_model.dart';
import 'package:ecommerce_app/features/auth/data/model/response_models/login_response_model.dart';
import 'package:ecommerce_app/features/auth/domain/entity/user_entity.dart';
import 'package:ecommerce_app/features/auth/domain/repository/auth_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthDataSource _authDataSource;

  AuthRepoImpl({required AuthDataSource authDataSource}) : _authDataSource = authDataSource;
  @override
  Future<Response<UserEntity?>> login(UserEntity user) async {
    try {
      LoginResponseModel responseModel = await _authDataSource.login(LoginRequestModel.fromDomain(user));
      UserEntity? userEntity = responseModel.user?.toDomain();
      return Success(data: userEntity);
    } catch (e) {
      ErrorModel error = ErrorModel.errorHandler(e);
      return Failure(errorModel: error);
    }
  }
}
