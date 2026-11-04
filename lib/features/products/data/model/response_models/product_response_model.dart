import 'package:ecommerce_app/features/category/data/model/response_models/category_response_model.dart';
import 'package:ecommerce_app/features/category/data/model/response_models/subcategory_response_model.dart';
import 'package:ecommerce_app/features/products/data/model/response_models/brand_response_model.dart';
import 'package:ecommerce_app/features/products/domain/entity/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product_response_model.g.dart';

@JsonSerializable()
class ProductResponseModel {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'slug')
  String? slug;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'imageCover')
  String? imageCover;
  @JsonKey(name: 'images')
  List<String>? images;
  @JsonKey(name: 'price')
  num? price;
  @JsonKey(name: 'quantity')
  int? quantity;
  @JsonKey(name: 'sold')
  int? sold;
  @JsonKey(name: 'ratingsAverage')
  num? ratingsAverage;
  @JsonKey(name: 'ratingsQuantity')
  int? ratingsQuantity;
  @JsonKey(name: 'category')
  CategoryResponseModel? category;
  @JsonKey(name: 'subcategory')
  List<SubcategoryResponseModel>? subcategory;
  @JsonKey(name: 'brand')
  BrandResponseModel? brand;
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;

  ProductResponseModel({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imageCover,
    this.images,
    this.price,
    this.quantity,
    this.sold,
    this.ratingsAverage,
    this.ratingsQuantity,
    this.category,
    this.subcategory,
    this.brand,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) => _$ProductResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseModelToJson(this);

  ProductEntity toDomain() => ProductEntity(
        id: id,
        title: title,
        description: description,
        imageCover: imageCover,
        images: images,
        price: price,
        quantity: quantity,
        sold: sold,
        ratingsAverage: ratingsAverage,
        ratingsQuantity: ratingsQuantity,
        category: category?.toDomain(),
        subcategory: subcategory?.map((model) => model.toDomain()).toList(),
        brand: brand?.toDomain(),
      );
}
