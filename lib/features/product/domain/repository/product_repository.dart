import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<String, List<ProductEntity>>> getDoctorChoice();
  Future<Either<String, List<ProductEntity>>> getProductByTitle(String title);
  Future<Either<String, List<ProductEntity>>> getAllProduct();
  Future<Either<String, bool>> toggleFavorite(ProductEntity product);
  Future<bool> getFavoriteState(String productID);
  Future<Either<String, List<ProductEntity>>> getFavoriteProducts();
}