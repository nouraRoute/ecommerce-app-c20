import 'package:json_annotation/json_annotation.dart';
part 'update_cart_item_request_model.g.dart';

/// Body of `PUT /cart/{id}`.
@JsonSerializable()
class UpdateCartItemRequestModel {
  @JsonKey(name: 'count')
  final int count;

  UpdateCartItemRequestModel({required this.count});

  factory UpdateCartItemRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateCartItemRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateCartItemRequestModelToJson(this);

  static UpdateCartItemRequestModel fromDomain(int count) => UpdateCartItemRequestModel(count: count);
}
