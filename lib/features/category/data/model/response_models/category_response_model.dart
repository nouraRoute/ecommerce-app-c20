import 'package:ecommerce_app/features/category/domain/entity/category_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'category_response_model.g.dart';

@JsonSerializable()
class CategoryResponseModel {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'slug')
  String? slug;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;

  CategoryResponseModel({this.id, this.name, this.slug, this.image, this.createdAt, this.updatedAt});

  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) => _$CategoryResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseModelToJson(this);

  CategoryEntity toDomain() => CategoryEntity(id: id, name: name, image: image);
}
