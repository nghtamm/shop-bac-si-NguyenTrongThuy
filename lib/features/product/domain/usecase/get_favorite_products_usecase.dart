import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/use_case/use_case.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/repository/product_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class GetFavoriteProductsUseCase implements UseCase<Either<String, List<ProductEntity>>, void> {
  @override
  Future<Either<String,List<ProductEntity>>> call({void params}) async {
    return await serviceLocator<ProductRepository>().getFavoriteProducts();
  }
}
