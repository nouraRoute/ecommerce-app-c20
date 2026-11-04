import 'package:ecommerce_app/features/category/data/model/response_models/metadata_response_model.dart';
import 'package:ecommerce_app/features/category/data/model/response_models/subcategory_response_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'get_subcategories_response_model.g.dart';

@JsonSerializable()
class GetSubcategoriesResponseModel {
  @JsonKey(name: 'results')
  int? results;
  @JsonKey(name: 'metadata')
  MetadataResponseModel? metadata;
  @JsonKey(name: 'data')
  List<SubcategoryResponseModel>? data;

  GetSubcategoriesResponseModel({this.results, this.metadata, this.data});

  factory GetSubcategoriesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetSubcategoriesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetSubcategoriesResponseModelToJson(this);
}
