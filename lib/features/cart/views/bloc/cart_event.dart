part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CartDisplayed extends CartEvent {}

class CartProductRemoved extends CartEvent {
  final String productID;

  CartProductRemoved({
    required this.productID,
  });

  @override
  List<Object> get props => [productID];
}

class CartDisposed extends CartEvent {
  final String displayName;

  CartDisposed({
    required this.displayName,
  });

  @override
  List<Object> get props => [displayName];
}

class CartProductAdded extends CartEvent {
  final AddToCartReq requirements;

  CartProductAdded({
    required this.requirements,
  });

  @override
  List<Object> get props => [requirements];
}
