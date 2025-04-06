part of 'orders_bloc.dart';

abstract class OrdersState extends Equatable {
  @override
  List<Object> get props => [];
}

class OrderInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final List<OrderModel> orders;

  OrdersLoaded({
    required this.orders,
  });

  @override
  List<Object> get props => [orders];
}

class OrdersLoadFailure extends OrdersState {
  final String message;

  OrdersLoadFailure({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class OrdersRegisterSuccess extends OrdersState {
  final String message;

  OrdersRegisterSuccess({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class OrdersRegisterFailure extends OrdersState {
  final String message;

  OrdersRegisterFailure({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
