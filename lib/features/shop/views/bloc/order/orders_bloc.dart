import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/order/order_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/usecase/order/get_order_history_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/usecase/order/order_registration_usecase.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(OrderInitial()) {
    on<DislayOrderHistory>(_onDisplayOrderHistory);
    on<OrderRegistered>(_onOrderRegistered);
  }

  Future<void> _onDisplayOrderHistory(
    DislayOrderHistory event,
    Emitter<OrdersState> emit,
  ) async {
    emit(OrdersLoading());

    final data = await serviceLocator<GetOrderHistoryUseCase>().call(
      params: {
        'customer': event.customerID,
      },
    );
    await data.fold(
      (left) async {
        emit(
          OrdersLoadFailure(
            message: left,
          ),
        );
      },
      (right) async {
        emit(
          OrdersLoaded(
            orders: right,
          ),
        );
      },
    );
  }

  Future<void> _onOrderRegistered(
    OrderRegistered event,
    Emitter<OrdersState> emit,
  ) async {
    emit(OrdersLoading());

    final data = await serviceLocator<OrderRegistrationUseCase>().call(
      params: event.data,
    );

    await data.fold(
      (left) async {
        emit(
          OrdersLoadFailure(
            message: left,
          ),
        );
      },
      (right) async {
        emit(
          OrdersLoaded(
            orders: right,
          ),
        );
      },
    );
  }
}
