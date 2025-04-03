import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/use_case/use_case.dart';
// import 'package:shop_bacsi_nguyentrongthuy/features/product/data/models/product.dart';
// import 'package:shop_bacsi_nguyentrongthuy/features/product/data/repository/product_repository_impl.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/repository/product_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class GetAllProductUseCase implements UseCase<Either, Map <String, dynamic>> {
  @override
  Future<Either> call({Map<String,dynamic>? params}) async {
    if(params == null) {
      return Left("Params không hợp lệ");
    }
    return await serviceLocator<ProductRepository>().getAllProduct(params);
  }
}
