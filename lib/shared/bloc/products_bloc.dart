import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/models/product_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/models/variation_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/models/wishlist_item_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/usecase/add_to_favorites_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/usecase/get_favorites_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/usecase/get_products_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/usecase/get_variations_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/usecase/get_doctor_choice_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/usecase/remove_from_favorites_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/usecase/search_product_usecase.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitial()) {
    on<AllProductsDisplayed>(_onAllProductsDisplayed);
    on<DoctorChoiceDisplayed>(_onDoctorChoiceDisplayed);
    on<SearchProductsDisplayed>(_onSearchProductsDisplayed);
    on<VariationsDisplayed>(_onVariationDisplayed);
    on<FavoritesDisplayed>(_onFavoritesDisplayed);
    on<FavoritesSynced>(_onFavoritesSynced);
    on<FavoriteProductAdded>(_onFavoriteProductAdded);
    on<FavoriteProductRemoved>(_onFavoriteProductRemoved);
  }

  Future<void> _onAllProductsDisplayed(
    AllProductsDisplayed event,
    Emitter<ProductsState> emit,
  ) async {
    final currentState = state;
    emit(ProductsLoading());

    final data = await serviceLocator<GetProductsUseCase>().call(
      params: {"per_page": 10},
    );

    await data.fold(
      (left) async => emit(ProductsLoadFailure(message: left.toString())),
      (right) async => emit(
        ProductsLoaded(
          products: right,
          favorites:
              currentState is ProductsLoaded ? currentState.favorites : [],
          variations:
              currentState is ProductsLoaded ? currentState.variations : [],
        ),
      ),
    );
  }

  Future<void> _onDoctorChoiceDisplayed(
    DoctorChoiceDisplayed event,
    Emitter<ProductsState> emit,
  ) async {
    final currentState = state;
    emit(ProductsLoading());

    final data = await serviceLocator<GetDoctorChoiceUseCase>().call(
      params: {
        'orderby': 'popularity',
        "per_page": 5,
      },
    );

    await data.fold(
      (left) async => emit(ProductsLoadFailure(message: left.toString())),
      (right) async => emit(
        ProductsLoaded(
          products: right,
          favorites:
              currentState is ProductsLoaded ? currentState.favorites : [],
          variations:
              currentState is ProductsLoaded ? currentState.variations : [],
        ),
      ),
    );
  }

  Future<void> _onSearchProductsDisplayed(
    SearchProductsDisplayed event,
    Emitter<ProductsState> emit,
  ) async {
    final currentState = state;
    emit(ProductsLoading());

    final data = await serviceLocator<SearchProductUseCase>().call(
      params: {"search": event.query},
    );

    await data.fold(
      (left) async => emit(ProductsLoadFailure(message: left.toString())),
      (right) async => emit(
        ProductsLoaded(
          products: right,
          favorites:
              currentState is ProductsLoaded ? currentState.favorites : [],
          variations:
              currentState is ProductsLoaded ? currentState.variations : [],
        ),
      ),
    );
  }

  Future<void> _onVariationDisplayed(
    VariationsDisplayed event,
    Emitter<ProductsState> emit,
  ) async {
    final currentState = state;

    final data = await serviceLocator<GetVariationsUseCase>().call(
      params: event.productID,
    );

    await data.fold(
      (left) async => emit(ProductsLoadFailure(message: left.toString())),
      (right) async => emit(
        ProductsLoaded(
          products: currentState is ProductsLoaded ? currentState.products : [],
          favorites:
              currentState is ProductsLoaded ? currentState.favorites : [],
          variations: right,
        ),
      ),
    );
  }

  Future<void> _onFavoritesSynced(
    FavoritesSynced event,
    Emitter<ProductsState> emit,
  ) async {
    final currentState = state;

    final data = await serviceLocator<GetFavoritesUseCase>().call();

    await data.fold(
      (left) async => emit(ProductsLoadFailure(message: left.toString())),
      (right) async {
        final favorites = right['favorites'] as List<WishlistItemModel>;

        emit(
          ProductsLoaded(
            products:
                currentState is ProductsLoaded ? currentState.products : [],
            favorites: favorites.cast<WishlistItemModel>(),
            variations:
                currentState is ProductsLoaded ? currentState.variations : [],
          ),
        );
      },
    );
  }

  Future<void> _onFavoritesDisplayed(
    FavoritesDisplayed event,
    Emitter<ProductsState> emit,
  ) async {
    final currentState = state;
    emit(ProductsLoading());

    final data = await serviceLocator<GetFavoritesUseCase>().call();

    await data.fold(
      (left) async => emit(ProductsLoadFailure(message: left.toString())),
      (right) async {
        final products = right['products'] as List<ProductModel>;
        final favorites = right['favorites'] as List<WishlistItemModel>;

        emit(
          ProductsLoaded(
            products: products,
            favorites: favorites.cast<WishlistItemModel>(),
            variations:
                currentState is ProductsLoaded ? currentState.variations : [],
          ),
        );
      },
    );
  }

  Future<void> _onFavoriteProductAdded(
    FavoriteProductAdded event,
    Emitter<ProductsState> emit,
  ) async {
    final currentState = state;
    emit(ProductsLoading());

    final data = await serviceLocator<AddToFavoritesUseCase>().call(
      params: {"product_id": event.productID},
    );

    await data.fold(
      (left) async => emit(ProductsLoadFailure(message: left.toString())),
      (right) async {
        final favoritesData =
            await serviceLocator<GetFavoritesUseCase>().call();
        final favorites = favoritesData.fold(
          (left) =>
              currentState is ProductsLoaded ? currentState.favorites : [],
          (right) => right['favorites'] as List<WishlistItemModel>,
        );

        emit(
          ProductsLoaded(
            products:
                currentState is ProductsLoaded ? currentState.products : [],
            favorites: favorites.cast<WishlistItemModel>(),
            variations:
                currentState is ProductsLoaded ? currentState.variations : [],
          ),
        );
      },
    );
  }

  Future<void> _onFavoriteProductRemoved(
    FavoriteProductRemoved event,
    Emitter<ProductsState> emit,
  ) async {
    final currentState = state;
    emit(ProductsLoading());

    final data = await serviceLocator<RemoveFromFavoritesUseCase>().call(
      params: event.itemID,
    );

    await data.fold(
      (left) async => emit(ProductsLoadFailure(message: left.toString())),
      (right) async {
        final favoritesData =
            await serviceLocator<GetFavoritesUseCase>().call();
        final favorites = favoritesData.fold(
          (left) =>
              currentState is ProductsLoaded ? currentState.favorites : [],
          (right) => right['favorites'] as List<WishlistItemModel>,
        );

        emit(
          ProductsLoaded(
            products:
                currentState is ProductsLoaded ? currentState.products : [],
            favorites: favorites.cast<WishlistItemModel>(),
            variations:
                currentState is ProductsLoaded ? currentState.variations : [],
          ),
        );
      },
    );
  }
}
