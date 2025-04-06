part of 'orders_bloc.dart';

abstract class OrdersEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DislayOrderHistory extends OrdersEvent {
  final String customerID;

  DislayOrderHistory({
    required this.customerID,
  });

  @override
  List<Object> get props => [customerID];
}

class OrderRegistered extends OrdersEvent {
  final OrderRegistrationReq requirements;

  OrderRegistered({
    required this.requirements,
  });

  @override
  List<Object> get props => [requirements];
}
