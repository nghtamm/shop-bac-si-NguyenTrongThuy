import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/use_case/use_case.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/repository/product/product_repository.dart';

class GetVariationsUseCase implements UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    if (params == null) {
      return const Left('Không có tham số được truyền vào!');
    }
    return serviceLocator<ProductRepository>().getVariations(params);
  }
}
