import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either> getDoctorChoice();

  Future<Either> getProductByTitle(String title);

  Future<Either> getAllProduct();

  Future<Either> toggleFavorite(ProductEntity product);

  Future<bool> getFavoriteState(String productID);

  Future<Either> getFavoriteProducts();
}
