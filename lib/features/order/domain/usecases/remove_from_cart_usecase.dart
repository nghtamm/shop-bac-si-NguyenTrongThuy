import 'package:shop_bacsi_nguyentrongthuy/core/use_case/use_case.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/repository/order_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class RemoveFromCartUseCase implements UseCase<void, String> {
  @override
  Future<void> call({String? params}) async {
    return serviceLocator<OrderRepository>().removeFromCart(params!);
  }
}
