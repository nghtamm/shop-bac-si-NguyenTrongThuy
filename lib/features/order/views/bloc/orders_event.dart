part of 'orders_bloc.dart';

abstract class OrdersEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OrdersDisplayed extends OrdersEvent {}

class OrderRegistered extends OrdersEvent {
  final OrderRegistrationReq requirements;

  OrderRegistered({
    required this.requirements,
  });

  @override
  List<Object> get props => [requirements];
}
