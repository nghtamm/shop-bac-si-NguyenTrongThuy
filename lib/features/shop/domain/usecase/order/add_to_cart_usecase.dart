import 'package:shop_bacsi_nguyentrongthuy/core/use_case/use_case.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/order/cart_item_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/repository/order/order_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class AddToCartUseCase implements UseCase<void, CartItemModel> {
  @override
  Future<void> call({CartItemModel? params}) async {
    return serviceLocator<OrderRepository>().addToCart(params!);
  }
}
