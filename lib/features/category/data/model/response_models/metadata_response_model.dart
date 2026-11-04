import 'package:json_annotation/json_annotation.dart';
part 'metadata_response_model.g.dart';

@JsonSerializable()
class MetadataResponseModel {
  @JsonKey(name: 'currentPage')
  int? currentPage;
  @JsonKey(name: 'numberOfPages')
  int? numberOfPages;
  @JsonKey(name: 'limit')
  int? limit;
  @JsonKey(name: 'nextPage')
  int? nextPage;

  MetadataResponseModel({this.currentPage, this.numberOfPages, this.limit, this.nextPage});

  factory MetadataResponseModel.fromJson(Map<String, dynamic> json) => _$MetadataResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataResponseModelToJson(this);
}
