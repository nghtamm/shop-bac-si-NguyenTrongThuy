import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/use_case/use_case.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/api_client_example/product_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/api_client_example/product_repo.dart';

class ProductUseCase
    implements UseCase<Either<String, List<ProductModel>>, void> {
  @override
  Future<Either<String, List<ProductModel>>> call({void params}) async {
    return await serviceLocator<ProductRepo>().getProducts();
  }
}
