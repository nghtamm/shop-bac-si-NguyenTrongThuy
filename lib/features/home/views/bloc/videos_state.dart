part of 'videos_bloc.dart';

abstract class VideosState extends Equatable {
  @override
  List<Object> get props => [];
}

class VideosInitial extends VideosState {}

class VideosLoading extends VideosState {}

class VideosLoaded extends VideosState {
  final List<VideosModel> videos;

  VideosLoaded({
    required this.videos,
  });

  @override
  List<Object> get props => [videos];
}

class VideosLoadFailure extends VideosState {
  final String message;

  VideosLoadFailure({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
