import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/local/global_storage.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/cart_item_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/repository/order_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/sources/order_firebase_service.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class OrderRepositoryImpl extends OrderRepository {
  @override
  Future<Either> getOrderHistory(Map<String, dynamic> data) async {
    return serviceLocator<OrderFirebaseService>().getOrderHistory(
      customerID: data['customer'] ?? '',
    );
  }

  @override
  Future<void> addToCart(CartItemModel item) async {
    return serviceLocator<GlobalStorage>().addToCart(item);
  }

  @override
  Future<Either<String, List<CartItemModel>>> displayCart() async {
    try {
      final cart = serviceLocator<GlobalStorage>().cart ?? [];
      return Right(cart);
    } catch (error) {
      return Left('Không thể hiển thị giỏ hàng: ${error.toString()}');
    }
  }

  @override
  Future<void> removeFromCart(String productID) async {
    return serviceLocator<GlobalStorage>().removeFromCart(productID);
  }

  @override
  Future<Either> orderRegistration(Map<String, dynamic> data) async {
    return await serviceLocator<OrderFirebaseService>().orderRegistration(
      data: data,
    );
  }

  @override
  Future<void> disposeCart() async {
    return serviceLocator<GlobalStorage>().clearCart();
  }
}
