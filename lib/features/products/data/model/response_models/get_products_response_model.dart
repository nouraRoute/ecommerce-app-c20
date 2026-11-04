import 'package:ecommerce_app/features/category/data/model/response_models/metadata_response_model.dart';
import 'package:ecommerce_app/features/products/data/model/response_models/product_response_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'get_products_response_model.g.dart';

@JsonSerializable()
class GetProductsResponseModel {
  @JsonKey(name: 'results')
  int? results;
  @JsonKey(name: 'metadata')
  MetadataResponseModel? metadata;
  @JsonKey(name: 'data')
  List<ProductResponseModel>? data;

  GetProductsResponseModel({this.results, this.metadata, this.data});

  factory GetProductsResponseModel.fromJson(Map<String, dynamic> json) => _$GetProductsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetProductsResponseModelToJson(this);
}
