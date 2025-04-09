import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/order/cart_item_model.dart';

class CartHelpers {
  static num calculateSubtotal(List<CartItemModel> products) {
    num subtotal = 0;

    for (var item in products) {
      subtotal = subtotal + item.subtotal;
    }
    return subtotal;
  }
}
