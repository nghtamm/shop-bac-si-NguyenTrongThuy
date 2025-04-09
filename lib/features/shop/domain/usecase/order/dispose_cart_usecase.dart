import 'package:shop_bacsi_nguyentrongthuy/core/use_case/use_case.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/repository/order/order_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class DisposeCartUseCase implements UseCase<void, void> {
  @override
  Future<void> call({void params}) async {
    return serviceLocator<OrderRepository>().disposeCart();
  }
}
