import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/data/models/news.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/data/sources/news_firebase_service.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/domain/repository/news_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

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
