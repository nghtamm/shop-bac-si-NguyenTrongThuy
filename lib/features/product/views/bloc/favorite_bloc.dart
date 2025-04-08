import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/models/favorite_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/repository/product_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final ProductRepository productRepository;

  FavoriteBloc({required this.productRepository}) : super(FavoriteInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<AddFavorite>(_onAddFavorite);
    on<RemoveFavorite>(_onRemoveFavorite);
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoriteState> emit,
  ) async {
    try {
      emit(FavoriteLoading());
      final result =
          await productRepository.getFavoriteProducts({'per_page': 10});
      result.fold(
        (failure) {
        emit(FavoriteLoadFailure(message: failure.toString()));
      },
        (favorites) {
        emit(FavoriteLoaded(favorites: favorites)); 
      },
      );
    } catch (e) {
      emit(FavoriteLoadFailure(message: e.toString()));
    }
  }

  Future<void> _onAddFavorite(
    AddFavorite event,
    Emitter<FavoriteState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is FavoriteLoaded) {
        emit(FavoriteLoading());
        final result = await productRepository.addToFavorites({
          'product_id': event.favoriteModel.productID,
        });
        result.fold(
          (failure) =>  emit(FavoriteLoadFailure(message: failure.toString())),
           
          (success) {
            final updatedFavorites = List<FavoriteModel>.from(currentState.favorites)
            ..add(event.favoriteModel);
          emit(FavoriteLoaded(favorites: updatedFavorites));
          },
        );
      }
    } catch (e) {
      emit(FavoriteLoadFailure(message: e.toString()));
    }
  }

  Future<void> _onRemoveFavorite(
    RemoveFavorite event,
    Emitter<FavoriteState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is FavoriteLoaded) {
        emit(FavoriteLoading());
        final result = await productRepository.removeFromFavorites({
          'item_id': event.itemID,
        });
        result.fold(
          (failure) => emit(FavoriteLoadFailure(message: failure.toString())),
          (success) {
            final updatedFavorites = currentState.favorites
                .where((favorite) => favorite.productID != event.itemID)
                .toList();
            emit(FavoriteLoaded(favorites: updatedFavorites));
          },
        );
      }
    } catch (e) {
      emit(FavoriteLoadFailure(message: e.toString()));
    }
  }
}
