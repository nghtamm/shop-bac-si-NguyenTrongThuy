import 'package:dartz/dartz.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/add_to_cart_req.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/repository/order.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/sources/order_firebase_service.dart';
import 'package:shop_bacsi_nguyentrongthuy/service_locator.dart';

class OrderRepositoryImpl extends OrderRepository {
  @override
  Future<Either> addtoCart(AddToCartReq addToCartReq) async {
    return serviceLocator<OrderFirebaseService>().addtoCart(addToCartReq);
  }
}
