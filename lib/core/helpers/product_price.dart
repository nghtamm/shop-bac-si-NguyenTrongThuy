import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';

class ProductPriceHelper {
  static num provideCurrentPrice(ProductEntity product) {
    return product.price.toInt();
  }
}
