import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/cart_item_model.dart';

abstract class OrderRepository {
  Future<Either> getOrderHistory(Map<String, dynamic> data);
  Future<void> addToCart(CartItemModel item);
  Future<Either<String, List<CartItemModel>>> displayCart();
  Future<void> removeFromCart(String productID);
  Future<Either> orderRegistration(Map<String, dynamic> data);
  Future<void> disposeCart();
}
