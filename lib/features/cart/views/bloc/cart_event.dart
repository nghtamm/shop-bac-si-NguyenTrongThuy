part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CartDisplayed extends CartEvent {}

class CartProductAdded extends CartEvent {
  final CartItemModel item;

  CartProductAdded({
    required this.item,
  });

  @override
  List<Object> get props => [item];
}

class CartProductRemoved extends CartEvent {
  final String key;

  CartProductRemoved({
    required this.key,
  });

  @override
  List<Object> get props => [key];
}

class CartDisposed extends CartEvent {}
