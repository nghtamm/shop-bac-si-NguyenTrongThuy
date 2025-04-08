part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<ProductModel> products;

  ProductsLoaded({
    required this.products,
  });

  @override
  List<Object> get props => [products];
}

class ProductsLoadFailure extends ProductsState {
  final String message;

  ProductsLoadFailure({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class VariationsLoaded extends ProductsState {
  final List<VariationModel> variations;

  VariationsLoaded({
    required this.variations,
  });

  @override
  List<Object> get props => [variations];
}

class VariationsLoadFailure extends ProductsState {
  final String message;

  VariationsLoadFailure({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
