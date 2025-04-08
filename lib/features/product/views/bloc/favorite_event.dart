part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadFavorites extends FavoriteEvent {}

class AddFavorite extends FavoriteEvent {
  final FavoriteModel favoriteModel;

  AddFavorite({required this.favoriteModel});

  @override
  List<Object?> get props => [favoriteModel];
}

class RemoveFavorite extends FavoriteEvent {
  final int itemID;

  RemoveFavorite({required this.itemID});

  @override
  List<Object?> get props => [itemID];
}