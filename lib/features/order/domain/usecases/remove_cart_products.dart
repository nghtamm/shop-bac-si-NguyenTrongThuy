import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/use_case/use_case.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/repository/order.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class RemoveCartProductUseCase implements UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return serviceLocator<OrderRepository>().removeCartProduct(params!);
  }
}
