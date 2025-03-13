part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<ProductOrderedEntity> products;

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

class CartDisposedSuccess extends CartState {
  final String displayName;

  CartDisposedSuccess({
    required this.displayName,
  });

  @override
  List<Object> get props => [displayName];
}

class CartProductAddSuccess extends CartState {
  final String message;

  CartProductAddSuccess({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class CartProductAddFailure extends CartState {
  final String message;

  CartProductAddFailure({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
