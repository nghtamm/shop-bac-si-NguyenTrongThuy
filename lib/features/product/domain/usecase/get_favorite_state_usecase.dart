import 'package:shop_bacsi_nguyentrongthuy/core/use_case/use_case.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/repository/product_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class GetFavoriteStateUseCase implements UseCase<bool, String> {
  @override
  Future<bool> call({String? params}) async {
    if (params == null || params.isEmpty) {
      throw ArgumentError("Không có tham số được truyền vào!");
    }
    return await serviceLocator<ProductRepository>().getFavoriteState(params);
  }
}
