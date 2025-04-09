part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AllProductsDisplayed extends ProductsEvent {
  final int page;

  AllProductsDisplayed({
    this.page = 1,
  });

  @override
  List<Object> get props => [page];
}

class DoctorChoiceDisplayed extends ProductsEvent {}

class SearchProductsDisplayed extends ProductsEvent {
  final String query;

  SearchProductsDisplayed({
    required this.query,
  });

  @override
  List<Object> get props => [query];
}

class VariationsDisplayed extends ProductsEvent {
  final String productID;

  VariationsDisplayed({
    required this.productID,
  });

  @override
  List<Object> get props => [productID];
}

class FavoritesDisplayed extends ProductsEvent {}

class FavoritesSynced extends ProductsEvent {}

class FavoriteProductAdded extends ProductsEvent {
  final int productID;

  FavoriteProductAdded({
    required this.productID,
  });

  @override
  List<Object> get props => [productID];
}

class FavoriteProductRemoved extends ProductsEvent {
  final int itemID;

  FavoriteProductRemoved({
    required this.itemID,
  });

  @override
  List<Object> get props => [itemID];
}
