import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/news/data/models/news.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/news/data/sources/news_firebase_service.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/news/domain/repository/news_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/service_locator.dart';

class NewRepositoryImpl extends NewRepository {
  @override
  Future<Either> getNews() async {
    var newsData = await serviceLocator<NewFirebaseService>().getNews();
    return newsData.fold((left) {
      return Left(left);
    }, (right) {
      return Right(
          List.from(right).map((e) => NewModel.fromMap(e).toEntity()).toList());
    });
  }
}
