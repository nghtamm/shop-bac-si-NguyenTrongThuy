import 'package:shop_bacsi_nguyentrongthuy/core/constants/app_urls.dart';

class ImageHelpers {
  static String generateProductImageURL(String id) {
    return '${AppURL.productImage}$id.png${AppURL.alt}';
  }

  static String generateNewsImageURL(String id) {
    return '${AppURL.newsImage}$id.jpg${AppURL.alt}';
  }
}
