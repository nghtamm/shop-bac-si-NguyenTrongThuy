import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/data/models/videos_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/domain/usecase/get_videos_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

part 'videos_event.dart';
part 'videos_state.dart';

class VideosBloc extends Bloc<VideosEvent, VideosState> {
  VideosBloc() : super(VideosInitial()) {
    on<VideosDisplayed>(_onVideosDisplayed);
  }

  Future<void> _onVideosDisplayed(
    VideosDisplayed event,
    Emitter<VideosState> emit,
  ) async {
    emit(VideosLoading());

    final data = await serviceLocator<GetVideosUseCase>().call(
      params: {
        'key': dotenv.env['GOOGLE_API_KEY'],
        'channelId': dotenv.env['YOUTUBE_CHANNEL_ID'],
        'part': 'snippet',
        'type': 'video',
        'maxResults': 10,
      },
    );
    await data.fold(
      (left) async {
        emit(
          VideosLoadFailure(
            message: left.toString(),
          ),
        );
      },
      (right) async {
        emit(
          VideosLoaded(
            videos: right,
          ),
        );
      },
    );
  }
}
