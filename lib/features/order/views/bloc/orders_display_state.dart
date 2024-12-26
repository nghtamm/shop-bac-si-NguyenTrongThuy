import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/entities/order.dart';

abstract class OrdersDisplayState {}

class OrdersLoading extends OrdersDisplayState {}

class OrdersLoaded extends OrdersDisplayState {
  final List<OrderEntity> orders;

  OrdersLoaded({required this.orders});
}

class OrdersLoadFailed extends OrdersDisplayState {
  final String errorMessage;

  OrdersLoadFailed({required this.errorMessage});
}
