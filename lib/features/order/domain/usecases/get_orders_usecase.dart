import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/use_case/use_case.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/repository/order_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class GetOrdersUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) {
    return serviceLocator<OrderRepository>().getOrders();
  }
}
