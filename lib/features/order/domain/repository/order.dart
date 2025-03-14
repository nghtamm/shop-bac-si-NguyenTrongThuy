import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/add_to_cart_req.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/order_registration_req.dart';

abstract class OrderRepository {
  Future<Either> addtoCart(AddToCartReq addToCartReq);
  Future<Either> getCartProducts();
  Future<Either> orderRegistration(OrderRegistrationReq order);
  Future<Either> removeCartProduct(String id);
  Future<Either> disposeCart();
  Future<Either> getOrders();
}
