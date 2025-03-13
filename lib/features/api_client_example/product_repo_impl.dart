import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/api_client_example/product_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/api_client_example/product_repo.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/api_client_example/product_service.dart';

class ProductRepoImpl extends ProductRepo {
  @override
  Future<Either<String, List<ProductModel>>> getProducts() async {
    return await serviceLocator<ProductService>().getProducts();
  }
}
