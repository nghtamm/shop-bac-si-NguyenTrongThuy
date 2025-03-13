import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/network/api_client.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/network/api_endpoints.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/network/api_methods.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/api_client_example/product_model.dart';

abstract class ProductService {
  Future<Either<String, List<ProductModel>>> getProducts();
}

class ProductServiceImpl implements ProductService {
  @override
  Future<Either<String, List<ProductModel>>> getProducts() async {
    try {
      final response = await serviceLocator<ApiClient>().request(
        endpoint: '${ApiEndpoints.woocommerce}products',
        method: ApiMethods.get,
        data: {},
      );

      if (response is List) {
        List<ProductModel> products = [];
        for (var item in response) {
          products.add(ProductModel.fromJson(item));
        }
        return Right(products);
      } else {
        return const Left("Định dạng dữ liệu không hợp lệ");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
