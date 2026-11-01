import 'package:ecommerce_app/features/auth/data/api/auth_api.dart';
import 'package:ecommerce_app/features/auth/data/model/request_models/login_request_model.dart';
import 'package:ecommerce_app/features/auth/data/model/request_models/register_request_model.dart';
import 'package:ecommerce_app/features/auth/data/model/response_models/login_response_model.dart';
import 'package:ecommerce_app/features/auth/data/model/response_models/register_response_model.dart';
import 'package:injectable/injectable.dart';

abstract class AuthDataSource {
  Future<LoginResponseModel> login(LoginRequestModel requestModel);
  Future<RegisterResponseModel> register(RegisterRequestModel requestModel);
}

@Injectable(as: AuthDataSource)
class AuthRemoteDataSource implements AuthDataSource {
  final AuthApi _authApi;

  AuthRemoteDataSource({required AuthApi authApi}) : _authApi = authApi;
  @override
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async => await _authApi.login(requestModel);
  @override
  Future<RegisterResponseModel> register(RegisterRequestModel requestModel) async =>
      await _authApi.register(requestModel);
}
