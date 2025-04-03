import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/models/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/usecase/get_all_product_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/usecase/get_doctor_choice_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/usecase/get_favorite_products_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/usecase/get_product_by_title_usecase.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitial()) {
    on<HomeProductsDisplayed>(_onHomeProductsDisplayed);
    on<SearchProductsDisplayed>(_onSearchProductsDisplayed);
    on<FavoritesDisplayed>(_onFavoritesDisplayed);
    on<AllProductsDisplayed>(_onAllProductsDisplayed);
  }

  Future<void> _onHomeProductsDisplayed(
      HomeProductsDisplayed event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());

    var data = await serviceLocator<GetDoctorChoiceUseCase>().call(
      params: {
        'orderby': 'popularity',
        "per_page": 5,
      },
    );
    await data.fold(
      (left) async {
        emit(ProductsLoadFailure());
      },
      (right) async {
        emit(ProductsLoaded(products: right));
      },
    );
  }

  Future<void> _onSearchProductsDisplayed(
      SearchProductsDisplayed event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());

    var data = await serviceLocator<GetProductByTitleUseCase>().call(
      params: {
        "search": event.query,
      },
    );
    await data.fold(
      (left) async {
        emit(ProductsLoadFailure());
      },
      (right) async {
        emit(ProductsLoaded(products: right));
      },
    );
  }

  Future<void> _onFavoritesDisplayed(
      FavoritesDisplayed event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());

    var data = await serviceLocator<GetFavoriteProductsUseCase>().call();
    await data.fold(
      (left) async {
        emit(ProductsLoadFailure());
      },
      (right) async {
        // emit(ProductsLoaded(products: right));
      },
    );
  }

  Future<void> _onAllProductsDisplayed(
      AllProductsDisplayed event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());

    var data = await serviceLocator<GetAllProductUseCase>().call(
      params: {
        "per_page": 10,
      },
    );

    await data.fold(
      (left) async {
        emit(ProductsLoadFailure());
      },
      (right) async {
        emit(ProductsLoaded(products: right));
      },
    );
  }
}
