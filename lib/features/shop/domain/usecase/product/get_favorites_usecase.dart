import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/use_case/use_case.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/repository/product/product_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class GetFavoritesUseCase implements UseCase<Either, void> {
  @override
  Future<Either> call({void params}) async {
    return await serviceLocator<ProductRepository>().getFavorites();
  }
}
