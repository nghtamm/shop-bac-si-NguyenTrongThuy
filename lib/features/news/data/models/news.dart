import 'package:shop_bacsi_nguyentrongthuy/features/news/domain/entities/news.dart';

class NewModel {
  final String newID;
  final String title;
  final String images;
  final String url;

  NewModel({
    required this.newID,
    required this.title,
    required this.images,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'newID': newID,
      'title': title,
      'images': images,
      'url': url,
    };
  }

  factory NewModel.fromMap(Map<String, dynamic> map) {
    return NewModel(
      newID: map['newID'] != null ? map['newID'] as String : '',
      title: map['title'] as String,
      images: map['images'] as String,
      url: map['url'] as String,
    );
  }
}

extension NewModelConvert on NewModel {
  NewEntity toEntity() {
    return NewEntity(
      newID: newID,
      title: title,
      images: images,
      url: url,
    );
  }
}

extension NewEntityConvert on NewEntity {
  NewModel toModel() {
    return NewModel(
      newID: newID,
      title: title,
      images: images,
      url: url,
    );
  }
}
