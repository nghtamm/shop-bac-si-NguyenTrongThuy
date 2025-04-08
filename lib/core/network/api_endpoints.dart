class ApiEndpoints {
  static const String baseURL = 'https://demo.unclecatvn.com';

  // WooCommerce API Endpoints
  static const String woocommerce = '$baseURL/wp-json/wc/v3/';

  // TI WooCommerce Wishlist API Endpoints
  static const String tiWishlist = '${woocommerce}wishlist/';
}
