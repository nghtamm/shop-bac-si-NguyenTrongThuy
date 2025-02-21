import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/usecases/get_orders_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/views/bloc/orders_display_state.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class OrdersDisplayCubit extends Cubit<OrdersDisplayState> {
  OrdersDisplayCubit() : super(OrdersLoading());

  void displayOrders() async {
    var ordersData = await serviceLocator<GetOrdersUseCase>().call();

    ordersData.fold((left) {
      emit(
        OrdersLoadFailed(errorMessage: left),
      );
    }, (right) {
      emit(
        OrdersLoaded(orders: right),
      );
    });
  }
}
