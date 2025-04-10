import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/network/api_client.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/network/api_methods.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/data/models/videos_model.dart';

abstract class VideosService {
  Future<Either> getVideos({
    required String key,
    required String channelId,
    required String part,
    required String type,
    required int maxResults,
  });
}

class VideosServiceImpl extends VideosService {
  @override
  Future<Either> getVideos({
    required String key,
    required String channelId,
    required String part,
    required String type,
    required int maxResults,
  }) async {
    try {
      final params = {
        'key': key,
        'channelId': channelId,
        'part': part,
        'type': type,
        'maxResults': maxResults,
      };

      final response = await serviceLocator<ApiClient>().request(
        endpoint: 'https://www.googleapis.com/youtube/v3/search',
        method: ApiMethods.get,
        queryParameters: params,
      );

      if (response is Map<String, dynamic> && response['items'] != null) {
        final items = List<Map<String, dynamic>>.from(response['items']);

        final videos = items.map((item) {
          final snippet = item['snippet'];
          return VideosModel(
            videoID: item['id']['videoId'],
            title: snippet['title'],
            thumbnailURL: snippet['thumbnails']['medium']['url'],
          );
        }).toList();

        return Right(videos);
      }

      return const Left('Không thể lấy dữ liệu video từ YouTube.');
    } catch (error) {
      return Left(
        error.toString(),
      );
    }
  }
}
