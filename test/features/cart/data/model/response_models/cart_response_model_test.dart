import 'dart:convert';

import 'package:ecommerce_app/features/cart/data/model/response_models/cart_response_model.dart';
import 'package:ecommerce_app/features/cart/domain/entity/cart_entity.dart';
import 'package:flutter_test/flutter_test.dart';

// Trimmed copies of real responses from https://ecommerce.routemisr.com/api/v1 (captured 2026-11-04).

const String _getCartJson = '''
{
  "status": "success",
  "numOfCartItems": 2,
  "cartId": "6aeb93efcfea3d001308e307",
  "data": {
    "_id": "6aeb93efcfea3d001308e307",
    "cartOwner": "6aeb93cecfea3d001308e2fd",
    "products": [
      {
        "count": 2,
        "_id": "6aeb93efcfea3d001308e308",
        "product": {
          "subcategory": [
            {"_id": "6407f1bcb575d3b90bf95797", "name": "Women's Clothing", "slug": "women's-clothing", "category": "6439d58a0049ad0b52b9003f"}
          ],
          "_id": "6428ebc6dc1175abc65ca0b9",
          "title": "Woman Shawl",
          "quantity": 220,
          "imageCover": "https://ecommerce.routemisr.com/Route-Academy-products/1680403397402-cover.jpeg",
          "category": {"_id": "6439d58a0049ad0b52b9003f", "name": "Women's Fashion", "slug": "women's-fashion", "image": "https://ecommerce.routemisr.com/Route-Academy-categories/1681511818071.jpeg"},
          "brand": {"_id": "64089bbe24b25627a253158b", "name": "DeFacto", "slug": "defacto", "image": "https://ecommerce.routemisr.com/Route-Academy-brands/1678285758109.png"},
          "ratingsAverage": 4.1,
          "id": "6428ebc6dc1175abc65ca0b9"
        },
        "price": 149
      },
      {
        "count": 1,
        "_id": "6aeb93f0cfea3d001308e311",
        "product": {
          "subcategory": [],
          "_id": "6428eb43dc1175abc65ca0b3",
          "title": "Woman Shawl",
          "imageCover": "https://ecommerce.routemisr.com/Route-Academy-products/1680403266739-cover.jpeg",
          "ratingsAverage": 4,
          "id": "6428eb43dc1175abc65ca0b3"
        },
        "price": 149
      }
    ],
    "createdAt": "2026-11-04T20:22:07.936Z",
    "updatedAt": "2026-11-04T20:22:09.067Z",
    "__v": 1,
    "totalCartPrice": 447
  }
}
''';

const String _addToCartJson = '''
{
  "status": "success",
  "message": "Product added successfully to your cart",
  "numOfCartItems": 1,
  "cartId": "6aeb93efcfea3d001308e307",
  "data": {
    "_id": "6aeb93efcfea3d001308e307",
    "cartOwner": "6aeb93cecfea3d001308e2fd",
    "products": [
      {"count": 1, "_id": "6aeb93efcfea3d001308e308", "product": "6428ebc6dc1175abc65ca0b9", "price": 149}
    ],
    "createdAt": "2026-11-04T20:22:07.936Z",
    "updatedAt": "2026-11-04T20:22:07.971Z",
    "__v": 0,
    "totalCartPrice": 149
  }
}
''';

const String _emptyCartJson = '''
{"status": "success", "numOfCartItems": 0, "data": {"products": [], "totalCartPrice": 0}}
''';

CartEntity _parse(String json) => CartResponseModel.fromJson(jsonDecode(json) as Map<String, dynamic>).toDomain();

void main() {
  group('CartResponseModel.toDomain', () {
    test('GET /cart maps the cart, its lines and the populated products', () {
      final cart = _parse(_getCartJson);

      expect(cart.id, '6aeb93efcfea3d001308e307');
      expect(cart.numOfCartItems, 2);
      expect(cart.totalCartPrice, 447);
      expect(cart.items, hasLength(2));

      final first = cart.items.first;
      expect(first.id, '6aeb93efcfea3d001308e308');
      expect(first.count, 2);
      expect(first.price, 149);
      expect(first.product?.id, '6428ebc6dc1175abc65ca0b9');
      expect(first.product?.title, 'Woman Shawl');
      expect(first.product?.imageCover, contains('1680403397402-cover.jpeg'));
      expect(first.product?.ratingsAverage, 4.1);
      expect(first.product?.category?.name, "Women's Fashion");
      expect(first.product?.brand?.name, 'DeFacto');
      expect(first.product?.subcategory?.single.name, "Women's Clothing");
      // Fields the cart endpoint does not send stay null instead of breaking parsing.
      expect(first.product?.price, isNull);
      expect(first.product?.description, isNull);
    });

    test('POST /cart sends the product as an id string and still maps into ProductEntity.id', () {
      final cart = _parse(_addToCartJson);

      expect(cart.id, '6aeb93efcfea3d001308e307');
      expect(cart.numOfCartItems, 1);
      expect(cart.totalCartPrice, 149);
      expect(cart.items, hasLength(1));
      expect(cart.items.single.count, 1);
      expect(cart.items.single.price, 149);
      expect(cart.items.single.product?.id, '6428ebc6dc1175abc65ca0b9');
      expect(cart.items.single.product?.title, isNull);
    });

    test('an empty cart has no id, zero items and a zero total', () {
      final cart = _parse(_emptyCartJson);

      expect(cart.id, isNull);
      expect(cart.numOfCartItems, 0);
      expect(cart.totalCartPrice, 0);
      expect(cart.items, isEmpty);
    });
  });
}
