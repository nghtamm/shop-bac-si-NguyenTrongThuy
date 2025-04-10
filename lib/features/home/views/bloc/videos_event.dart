part of 'videos_bloc.dart';

abstract class VideosEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class VideosDisplayed extends VideosEvent {}
