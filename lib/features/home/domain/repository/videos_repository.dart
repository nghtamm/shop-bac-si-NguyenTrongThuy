import 'package:fpdart/fpdart.dart';

abstract class VideosRepository {
  Future<Either> getVideos(Map<String, dynamic> data);
}
