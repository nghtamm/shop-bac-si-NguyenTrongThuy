import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/use_case/use_case.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/repository/product/product_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class AddToFavoritesUseCase implements UseCase<Either, Map<String, dynamic>> {
  @override
  Future<Either> call({Map<String, dynamic>? params}) async {
    if (params == null) {
      return const Left("Không có tham số được truyền vào!");
    }
    return await serviceLocator<ProductRepository>().addToFavorites(params);
  }
}
