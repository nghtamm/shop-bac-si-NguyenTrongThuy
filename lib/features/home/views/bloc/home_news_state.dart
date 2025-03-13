part of 'home_news_bloc.dart';

abstract class HomeNewsState extends Equatable {
  @override
  List<Object> get props => [];
}

class NewsInitial extends HomeNewsState {}

class NewsLoading extends HomeNewsState {}

class NewsLoaded extends HomeNewsState {
  final List<NewEntity> news;

  NewsLoaded({
    required this.news,
  });

  @override
  List<Object> get props => [news];
}

class NewsLoadFailure extends HomeNewsState {}
