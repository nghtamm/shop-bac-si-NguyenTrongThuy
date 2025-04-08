import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/models/product_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either> getDoctorChoice(Map<String, dynamic> data);
  Future<Either> searchProduct(Map<String, dynamic> data);
  Future<Either> getAllProduct(Map<String, dynamic> data);
  // Future<Either> getDetailProduct(Map<String, dynamic> data);
  Future<Either> addToFavorites(Map<String, dynamic> data);
  Future<Either> removeFromFavorites(Map<String, dynamic> data);
  Future<Either> getFavoriteState(Map<String, dynamic> data);
  Future<Either> getFavoriteProducts(Map<String, dynamic> data);
}
