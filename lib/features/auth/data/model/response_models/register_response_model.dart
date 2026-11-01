import 'package:ecommerce_app/features/auth/data/model/response_models/user_response_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'register_response_model.g.dart';

@JsonSerializable()
class RegisterResponseModel {
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'user')
  UserResponseModel? user;
  @JsonKey(name: 'token')
  String? token;

  RegisterResponseModel({this.message, this.user, this.token});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) => _$RegisterResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseModelToJson(this);
}
