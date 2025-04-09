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
  final bool hasReachedMax;

  ProductsLoaded({
    required this.products,
    this.favorites = const [],
    this.variations = const [],
    this.hasReachedMax = false,
  });

  ProductsLoaded copyWith({
    List<ProductModel>? products,
    List<WishlistItemModel>? favorites,
    List<VariationModel>? variations,
    bool? hasReachedMax,
  }) {
    return ProductsLoaded(
      products: products ?? this.products,
      favorites: favorites ?? this.favorites,
      variations: variations ?? this.variations,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [products, favorites, variations, hasReachedMax];
}

class ProductsLoadFailure extends ProductsState {
  final String message;

  ProductsLoadFailure({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
