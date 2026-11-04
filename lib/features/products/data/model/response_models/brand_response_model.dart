import 'package:ecommerce_app/features/products/domain/entity/brand_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'brand_response_model.g.dart';

@JsonSerializable()
class BrandResponseModel {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'slug')
  String? slug;
  @JsonKey(name: 'image')
  String? image;

  BrandResponseModel({this.id, this.name, this.slug, this.image});

  factory BrandResponseModel.fromJson(Map<String, dynamic> json) => _$BrandResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BrandResponseModelToJson(this);

  BrandEntity toDomain() => BrandEntity(id: id, name: name, image: image);
}
