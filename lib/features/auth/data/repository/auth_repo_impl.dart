import 'package:ecommerce_app/core/error/error_model.dart';
import 'package:ecommerce_app/core/network/models/response_model.dart';
import 'package:ecommerce_app/core/resources/constants_manager.dart';
import 'package:ecommerce_app/features/auth/data/data_source/auth_data_source.dart';
import 'package:ecommerce_app/features/auth/data/model/request_models/login_request_model.dart';
import 'package:ecommerce_app/features/auth/data/model/request_models/register_request_model.dart';
import 'package:ecommerce_app/features/auth/data/model/response_models/login_response_model.dart';
import 'package:ecommerce_app/features/auth/data/model/response_models/register_response_model.dart';
import 'package:ecommerce_app/features/auth/domain/entity/user_entity.dart';
import 'package:ecommerce_app/features/auth/domain/repository/auth_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthDataSource _authDataSource;
  final SharedPreferences _sharedPreferences;

  AuthRepoImpl({required AuthDataSource authDataSource, required SharedPreferences sharedPreferences})
      : _authDataSource = authDataSource,
        _sharedPreferences = sharedPreferences;
  @override
  Future<Response<UserEntity?>> login(UserEntity user) async {
    try {
      LoginResponseModel responseModel = await _authDataSource.login(LoginRequestModel.fromDomain(user));
      UserEntity? userEntity = responseModel.user?.toDomain();
      await _sharedPreferences.setString(AppConstants.tokenKey, responseModel.token ?? '');
      return Success(data: userEntity);
    } catch (e) {
      ErrorModel error = ErrorModel.errorHandler(e);
      return Failure(errorModel: error);
    }
  }

  @override
  Future<Response<UserEntity?>> register(UserEntity user) async {
    try {
      RegisterResponseModel responseModel = await _authDataSource.register(RegisterRequestModel.fromDomain(user));
      UserEntity? userEntity = responseModel.user?.toDomain();
      await _sharedPreferences.setString(AppConstants.tokenKey, responseModel.token ?? '');
      return Success(data: userEntity);
    } catch (e) {
      ErrorModel error = ErrorModel.errorHandler(e);
      return Failure(errorModel: error);
    }
  }

  @override
  bool checkLogin() {
    return _sharedPreferences.getString(AppConstants.tokenKey) != null;
  }
}
