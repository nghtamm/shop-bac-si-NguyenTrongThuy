part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<ProductModel> products;
  final List<WishlistItemModel> favorites;
  final List<VariationModel> variations;

  ProductsLoaded({
    required this.products,
    this.favorites = const [],
    this.variations = const [],
  });

  @override
  List<Object> get props => [products, favorites, variations];
}

class ProductsLoadFailure extends ProductsState {
  final String message;

  ProductsLoadFailure({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
