import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/debouncer.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/product/product_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/product/variation_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/favorites/wishlist_item_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/usecase/product/add_to_favorites_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/usecase/product/get_favorites_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/usecase/product/get_products_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/usecase/product/get_variations_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/usecase/product/get_doctor_choice_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/usecase/product/remove_from_favorites_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/usecase/product/search_product_usecase.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final Debouncer _debouncer = Debouncer(
    delay: const Duration(
      milliseconds: 500,
    ),
  );

  int currentPage = 1;
  bool _isFetching = false;

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
    if (_isFetching) return;
    _isFetching = true;

    final currentState = state;
    if (event.page == 1) emit(ProductsLoading());

    final data = await serviceLocator<GetProductsUseCase>().call(
      params: {
        "per_page": 8,
        "page": event.page,
      },
    );

    await data.fold(
      (left) async => emit(
        ProductsLoadFailure(
          message: left.toString(),
        ),
      ),
      (right) async {
        final hasReachedMax = right.isEmpty;

        if (currentState is ProductsLoaded && event.page > 1) {
          emit(
            currentState.copyWith(
              products: currentState.products + right,
              hasReachedMax: hasReachedMax,
            ),
          );
        } else {
          emit(
            ProductsLoaded(
              products: right,
              favorites:
                  currentState is ProductsLoaded ? currentState.favorites : [],
              variations:
                  currentState is ProductsLoaded ? currentState.variations : [],
              hasReachedMax: hasReachedMax,
            ),
          );
        }

        currentPage = event.page;
      },
    );

    _isFetching = false;
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
      (left) async => emit(
        ProductsLoadFailure(
          message: left.toString(),
        ),
      ),
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

    await _debouncer.asynchronousDebounce(() async {
      final data = await serviceLocator<SearchProductUseCase>().call(
        params: {"search": event.query},
      );

      await data.fold(
        (left) async => emit(
          ProductsLoadFailure(
            message: left.toString(),
          ),
        ),
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
    });
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
      (left) async => emit(
        ProductsLoadFailure(
          message: left.toString(),
        ),
      ),
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
      (left) async => emit(
        ProductsLoadFailure(
          message: left.toString(),
        ),
      ),
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
      (left) async => emit(
        ProductsLoadFailure(
          message: left.toString(),
        ),
      ),
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
      params: {
        "product_id": event.productID,
      },
    );

    await data.fold(
      (left) async => emit(
        ProductsLoadFailure(
          message: left.toString(),
        ),
      ),
      (right) async {
        final favData = await serviceLocator<GetFavoritesUseCase>().call();
        final favorites = favData.fold(
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
      (left) async => emit(
        ProductsLoadFailure(
          message: left.toString(),
        ),
      ),
      (right) async {
        final favData = await serviceLocator<GetFavoritesUseCase>().call();
        final favorites = favData.fold(
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
