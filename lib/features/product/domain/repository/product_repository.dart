import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either> getDoctorChoice(Map <String, dynamic> data);
  Future<Either> getProductByTitle(Map <String, dynamic> data);
  Future<Either> getAllProduct(Map <String, dynamic> data);
  Future<Either<String, bool>> toggleFavorite(ProductEntity product);
  Future<bool> getFavoriteState(String productID);
  Future<Either<String, List<ProductEntity>>> getFavoriteProducts();
}