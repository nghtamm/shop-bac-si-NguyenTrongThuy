import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/network/api_client.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/network/api_endpoints.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/network/api_methods.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/add_to_cart_req.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/order_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/order_registration_req.dart';

abstract class OrderFirebaseService {
  Future<Either> getOrderHistory({
    required String customerID,
  });

  Future<Either<String, String>> addtoCart(AddToCartReq addToCartReq);
  Future<Either> removeCartProduct(String id);
  Future<Either> getCartProducts();
  Future<Either> orderRegistration(OrderRegistrationReq order);
  Future<Either> disposeCart();
}

class OrderFirebaseServiceImpl extends OrderFirebaseService {
  @override
  Future<Either> getOrderHistory({
    required String customerID,
  }) async {
    try {
      final params = {
        'customer': customerID,
      };

      final response = await serviceLocator<ApiClient>().request(
        endpoint: "${ApiEndpoints.woocommerce}orders",
        method: ApiMethods.get,
        queryParameters: params,
      );

      if (response is List) {
        final parsed = response
            .where((order) => order is Map<String, dynamic>)
            .map((order) => OrderModel.fromJson(order as Map<String, dynamic>))
            .toList();
        return Right(parsed);
      }

      return const Left('Không tìm thấy lịch sử đơn hàng của người dùng.');
    } catch (error) {
      return const Left(
        'Đã xảy ra lỗi không xác định khi lấy lịch sử đơn mua của người dùng. Vui lòng thử lại sau.',
      );
    }
  }

  @override
  Future<Either<String, String>> addtoCart(AddToCartReq addToCartReq) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('Cart')
          .add(addToCartReq.toMap());
      return const Right('Thêm vào giỏ thành công');
    } catch (e) {
      return const Left('Lỗi khi thêm vào giỏ');
    }
  }

  @override
  Future<Either> getCartProducts() async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      var returnedData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('Cart')
          .get();
      List<Map> products = [];
      for (var item in returnedData.docs) {
        var data = item.data();
        data.addAll({'id': item.id});
        products.add(data);
      }
      return Right(products);
    } catch (e) {
      return const Left('Please try again');
    }
  }

  @override
  Future<Either> removeCartProduct(String id) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('Cart')
          .doc(id)
          .delete();
      return const Right('Product removed successfully');
    } catch (e) {
      return const Left('Please try again');
    }
  }

  @override
  Future<Either> orderRegistration(OrderRegistrationReq order) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('Orders')
          .add(order.toMap());
      return const Right('Order registered successfully');
    } catch (e) {
      return const Left('Please try again');
    }
  }

  @override
  Future<Either> disposeCart() async {
    try {
      var currentUser = FirebaseAuth.instance.currentUser;
      var returnedData = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .collection('Cart')
          .get();
      for (var item in returnedData.docs) {
        await item.reference.delete();
      }
      return const Right('Đặt hàng thành công!');
    } catch (e) {
      return const Left('Please try again');
    }
  }
}
