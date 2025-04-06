import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/order_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/order_registration_req.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/usecases/get_orders_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/usecases/order_registration.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(OrdersLoading()) {
    on<DislayOrderHistory>(_onDisplayOrderHistory);
    on<OrderRegistered>(_onOrderRegistered);
  }

  Future<void> _onDisplayOrderHistory(
    DislayOrderHistory event,
    Emitter<OrdersState> emit,
  ) async {
    emit(OrdersLoading());

    var data = await serviceLocator<GetOrdersUseCase>().call(
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
      OrderRegistered event, Emitter<OrdersState> emit) async {
    emit(OrdersLoading());

    var data = await serviceLocator<OrderRegistrationUseCase>().call(
      params: event.requirements,
    );

    await data.fold(
      (left) async {
        emit(OrdersRegisterFailure(message: left));
      },
      (right) async {
        emit(OrdersRegisterSuccess(message: right));
      },
    );
  }
}
