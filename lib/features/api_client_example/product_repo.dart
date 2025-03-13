import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/api_client_example/product_model.dart';

abstract class ProductRepo {
  Future<Either<String, List<ProductModel>>> getProducts();
}
