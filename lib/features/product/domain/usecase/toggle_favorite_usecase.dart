import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/use_case/use_case.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product_entity.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/repository/product_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class ToggleFavoriteUseCase implements UseCase<Either<String,bool>, ProductEntity> {
  @override
  Future<Either<String,bool>> call({ProductEntity? params}) async {
    if (params == null ) {
      return const Left("Không có tham số được truyền vào!");
    }
    return await serviceLocator<ProductRepository>().toggleFavorite(params);
  }
}
