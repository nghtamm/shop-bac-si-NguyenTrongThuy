class ApiEndpoints {
  static const String baseURL = 'https://demo.unclecatvn.com';

  // WooCommerce API Endpoints
  static const String woocommerce = '$baseURL/wp-json/wc/v3/';

  // SimpleJWT Login API Endpoints
  static const String simpleJWT = '$baseURL/?rest_route=/simple-jwt-login/v1/';

  // TI WooCommerce Wishlist API Endpoints
  static const String tiWishlist = '$woocommerce/wishlist/';
}
