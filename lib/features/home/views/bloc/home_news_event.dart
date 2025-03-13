part of 'home_news_bloc.dart';

abstract class HomeNewsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NewsDisplayed extends HomeNewsEvent {}
