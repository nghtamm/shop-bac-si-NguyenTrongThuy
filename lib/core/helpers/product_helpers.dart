import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product_entity.dart';

class ProductHelpers {
  static num provideCurrentPrice(ProductEntity product) {
    return product.price;
  }
}
