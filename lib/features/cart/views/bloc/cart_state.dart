part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemModel> products;

  CartLoaded({
    required this.products,
  });

  @override
  List<Object> get props => [products];
}

class CartLoadFailure extends CartState {
  final String message;

  CartLoadFailure({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
