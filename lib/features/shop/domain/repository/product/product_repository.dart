import 'package:fpdart/fpdart.dart';

abstract class ProductRepository {
  Future<Either> getDoctorChoice(Map<String, dynamic> data);
  Future<Either> searchProduct(Map<String, dynamic> data);
  Future<Either> getProducts(Map<String, dynamic> data);
  Future<Either> getVariations(String productID);
  Future<Either> getFavorites();
  Future<Either> addToFavorites(Map<String, dynamic> data);
  Future<Either> removeFromFavorites(int itemID);
}
