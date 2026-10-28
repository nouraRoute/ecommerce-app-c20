import 'package:ecommerce_app/features/auth/domain/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_response_model.g.dart';

@JsonSerializable()
class UserResponseModel {
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'role')
  String? role;

  UserResponseModel({this.name, this.email, this.role});

  factory UserResponseModel.fromJson(Map<String, dynamic> json) => _$UserResponseModelFromJson(json);

  static List<UserResponseModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(UserResponseModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$UserResponseModelToJson(this);
  UserEntity toDomain() => UserEntity(email: email, name: name);
}
