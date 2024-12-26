import 'package:dartz/dartz.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/add_to_cart_req.dart';

abstract class OrderRepository {
  Future<Either> addtoCart(AddToCartReq addToCartReq);
  Future<Either> getCartProducts();

  Future<Either> removeCartProduct(String id);
}
