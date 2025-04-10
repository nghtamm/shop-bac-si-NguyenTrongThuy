class VideosModel {
  final String videoID;
  final String title;
  final String thumbnailURL;

  VideosModel({
    required this.videoID,
    required this.title,
    required this.thumbnailURL,
  });

  String get url => 'https://www.youtube.com/watch?v=$videoID';
}
