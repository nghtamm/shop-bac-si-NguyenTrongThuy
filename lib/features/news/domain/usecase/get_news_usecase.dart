import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/usecase/use_case.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/news/domain/repository/news_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/service_locator.dart';

class GetNewsUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({dynamic params}) async {
    return await serviceLocator<NewRepository>().getNews();
  }
}
