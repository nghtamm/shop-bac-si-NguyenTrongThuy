import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/add_to_cart_req.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/order.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/order_registration_req.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/product_ordered.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/repository/order.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/sources/order_firebase_service.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class OrderRepositoryImpl extends OrderRepository {
  @override
  Future<Either> addtoCart(AddToCartReq addToCartReq) async {
    return serviceLocator<OrderFirebaseService>().addtoCart(addToCartReq);
  }

  @override
  Future<Either> getCartProducts() async {
    var returnedData =
        await serviceLocator<OrderFirebaseService>().getCartProducts();
    return returnedData.fold((error) {
      return Left(error);
    }, (data) {
      return Right(List.from(data)
          .map((e) => ProductOrderedModel.fromMap(e).toEntity())
          .toList());
    });
  }

  @override
  Future<Either> removeCartProduct(String id) async {
    var returnedData =
        await serviceLocator<OrderFirebaseService>().removeCartProduct(id);
    return returnedData.fold((error) {
      return Left(error);
    }, (message) {
      return Right(message);
    });
  }

  @override
  Future<Either> orderRegistration(OrderRegistrationReq order) async {
    var returnedData =
        await serviceLocator<OrderFirebaseService>().orderRegistration(order);
    return returnedData.fold((error) {
      return Left(error);
    }, (message) {
      return Right(message);
    });
  }

  @override
  Future<Either> disposeCart() async {
    return await serviceLocator<OrderFirebaseService>().disposeCart();
  }

  @override
  Future<Either> getOrders() async {
    var returnedData = await serviceLocator<OrderFirebaseService>().getOrders();
    return returnedData.fold((left) {
      return Left(left);
    }, (right) {
      return Right(List.from(right)
          .map((e) => OrderModel.fromMap(e).toEntity())
          .toList());
    });
  }
}
