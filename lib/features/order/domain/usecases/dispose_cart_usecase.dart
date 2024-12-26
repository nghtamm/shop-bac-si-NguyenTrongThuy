import 'package:dartz/dartz.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/usecase/use_case.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/repository/order.dart';
import 'package:shop_bacsi_nguyentrongthuy/service_locator.dart';

class DisposeCartUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({dynamic params}) async {
    return serviceLocator<OrderRepository>().disposeCart();
  }
}
