import 'package:ecommerce_app/features/auth/domain/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'register_request_model.g.dart';

@JsonSerializable()
class RegisterRequestModel {
  final String name;
  final String email;
  final String password;
  final String rePassword;
  final String phone;

  RegisterRequestModel({
    required this.name,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.phone,
  });
  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) => _$RegisterRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterRequestModelToJson(this);
  static RegisterRequestModel fromDomain(UserEntity user) {
    return RegisterRequestModel(
      name: user.name ?? '',
      email: user.email ?? '',
      password: user.password ?? '',
      rePassword: user.password ?? '',
      phone: user.phoneNumber ?? '',
    );
  }

  UserEntity toDomain() => UserEntity(name: name, email: email, password: password, phoneNumber: phone);
}
