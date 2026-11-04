import 'package:ecommerce_app/features/category/data/model/response_models/category_response_model.dart';
import 'package:ecommerce_app/features/category/data/model/response_models/metadata_response_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'get_categories_response_model.g.dart';

@JsonSerializable()
class GetCategoriesResponseModel {
  @JsonKey(name: 'results')
  int? results;
  @JsonKey(name: 'metadata')
  MetadataResponseModel? metadata;
  @JsonKey(name: 'data')
  List<CategoryResponseModel>? data;

  GetCategoriesResponseModel({this.results, this.metadata, this.data});

  factory GetCategoriesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetCategoriesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetCategoriesResponseModelToJson(this);
}
