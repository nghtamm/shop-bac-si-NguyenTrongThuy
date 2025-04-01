import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/use_case/use_case.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/repository/product_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class GetProductByTitleUseCase implements UseCase<Either<String, List<ProductEntity>>, String> {
  @override
  Future<Either<String, List<ProductEntity>>> call({String? params}) async {
    if (params == null || params.isEmpty) {
      return const Left("Không có tham số được truyền vào!");
    }
    return await serviceLocator<ProductRepository>().getProductByTitle(params);
  }
}
