class Endpoints {
  static const String loginEndpoint = '/auth/signin';
  static const String registerEndpoint = '/auth/signup';
  static const String getCategoriesEndpoint = '/categories';
  static const String getSubcategoriesEndpoint = '/categories/{id}/subcategories';
  static const String getProductsEndpoint = '/products';
  static const String getCartEndpoint = '/cart';
  static const String addToCartEndpoint = '/cart';
  static const String updateCartItemEndpoint = '/cart/{id}';
  static const String removeFromCartEndpoint = '/cart/{id}';
}
