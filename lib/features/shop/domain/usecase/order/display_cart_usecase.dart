import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/use_case/use_case.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/order/cart_item_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/repository/order/order_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class DisplayCartUseCase
    implements UseCase<Either<String, List<CartItemModel>>, void> {
  @override
  Future<Either<String, List<CartItemModel>>> call({void params}) async {
    return serviceLocator<OrderRepository>().displayCart();
  }
}
