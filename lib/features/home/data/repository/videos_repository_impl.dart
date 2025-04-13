import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/data/sources/videos_service.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/domain/repository/videos_repository.dart';

class VideosRepositoryImpl extends VideosRepository {
  @override
  Future<Either> getVideos(Map<String, dynamic> data) {
    return serviceLocator<VideosService>().getVideos(
      key: data['key'] ?? dotenv.env['GOOGLE_API_KEY'],
      channelId: data['channelId'] ?? dotenv.env['YOUTUBE_CHANNEL_ID'],
      part: data['part'] ?? 'snippet',
      type: data['type'] ?? 'video',
      maxResults: data['maxResults'] ?? 10,
    );
  }
}
