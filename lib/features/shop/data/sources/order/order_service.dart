import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/network/api_client.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/network/api_endpoints.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/network/api_methods.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/order/order_model.dart';

abstract class OrderService {
  Future<Either> getOrderHistory({
    required String customerID,
  });
  Future<Either> orderRegistration({
    required Map<String, dynamic> data,
  });
}

class OrderServiceImpl extends OrderService {
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
            .whereType<Map<String, dynamic>>()
            .map((order) => OrderModel.fromJson(order))
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
  Future<Either> orderRegistration({
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await serviceLocator<ApiClient>().request(
        endpoint: "${ApiEndpoints.woocommerce}orders",
        method: ApiMethods.post,
        data: data,
      );

      OrderModel? order;
      if (response is Map<String, dynamic>) {
        order = OrderModel.fromJson(response);
      }
      
      return Right(
        order != null ? [order] : [],
      );
    } catch (error) {
      return const Left('Đã xảy ra lỗi không xác định khi đặt hàng.');
    }
  }
}
