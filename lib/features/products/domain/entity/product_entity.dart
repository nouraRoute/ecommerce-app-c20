import 'package:ecommerce_app/features/category/domain/entity/category_entity.dart';
import 'package:ecommerce_app/features/products/domain/entity/brand_entity.dart';
import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final String? imageCover;
  final List<String>? images;
  final num? price;
  final int? quantity;
  final int? sold;
  final num? ratingsAverage;
  final int? ratingsQuantity;
  final CategoryEntity? category;
  final List<CategoryEntity>? subcategory;
  final BrandEntity? brand;

  const ProductEntity({
    this.id,
    this.title,
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
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        imageCover,
        images,
        price,
        quantity,
        sold,
        ratingsAverage,
        ratingsQuantity,
        category,
        subcategory,
        brand,
      ];
}
