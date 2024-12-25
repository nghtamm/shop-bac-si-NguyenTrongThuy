import 'package:shop_bacsi_nguyentrongthuy/features/news/domain/entities/news.dart';

abstract class NewsDisplayState {}

class NewsInitialState extends NewsDisplayState {}

class NewsLoading extends NewsDisplayState {}

class NewsLoaded extends NewsDisplayState {
  final List<NewEntity> news;

  NewsLoaded({required this.news});
}

class NewsLoadFailed extends NewsDisplayState {}
