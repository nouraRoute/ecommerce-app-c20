import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/network/endpoints.dart';
import 'package:ecommerce_app/features/auth/data/model/request_models/login_request_model.dart';
import 'package:ecommerce_app/features/auth/data/model/response_models/login_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api.g.dart';

@injectable
@RestApi()
abstract class AuthApi {
  @factoryMethod
  factory AuthApi(Dio dio) = _AuthApi;
  @POST(Endpoints.loginEndpoint)
  Future<LoginResponseModel> login(@Body() LoginRequestModel requestModel);
}
