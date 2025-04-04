part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  @override
  List<Object> get props => [];
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

class FavoritesDisplayed extends ProductsEvent {}

class AllProductsDisplayed extends ProductsEvent {}
