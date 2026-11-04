import 'package:ecommerce_app/features/category/domain/entity/category_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'subcategory_response_model.g.dart';

@JsonSerializable()
class SubcategoryResponseModel {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'slug')
  String? slug;
  @JsonKey(name: 'category')
  String? category;
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;

  SubcategoryResponseModel({this.id, this.name, this.slug, this.category, this.createdAt, this.updatedAt});

  factory SubcategoryResponseModel.fromJson(Map<String, dynamic> json) => _$SubcategoryResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubcategoryResponseModelToJson(this);

  CategoryEntity toDomain() => CategoryEntity(id: id, name: name);
}
