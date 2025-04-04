import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/models/product_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either> getDoctorChoice(Map<String, dynamic> data);
  Future<Either> searchProduct(Map<String, dynamic> data);
  Future<Either> getAllProduct(Map<String, dynamic> data);
  Future<Either<String, bool>> toggleFavorite(ProductEntity product);
  Future<bool> getFavoriteState(String productID);
  Future<Either<String, List<ProductModel>>> getFavoriteProducts();
}
