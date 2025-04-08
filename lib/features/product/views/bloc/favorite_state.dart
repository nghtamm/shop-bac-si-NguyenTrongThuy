part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<FavoriteModel> favorites;

  FavoriteLoaded({required this.favorites});

  @override
  List<Object?> get props => [favorites];
}

class FavoriteLoadFailure extends FavoriteState {
  final String message;

  FavoriteLoadFailure({required this.message});

  @override
  List<Object?> get props => [message];
}