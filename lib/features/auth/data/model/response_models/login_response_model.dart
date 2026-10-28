import 'package:ecommerce_app/features/auth/data/model/response_models/user_response_model.dart';
import 'package:ecommerce_app/features/auth/domain/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'user')
  UserResponseModel? user;
  @JsonKey(name: 'token')
  String? token;

  LoginResponseModel({this.message, this.user, this.token});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => _$LoginResponseModelFromJson(json);

  static List<LoginResponseModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(LoginResponseModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
