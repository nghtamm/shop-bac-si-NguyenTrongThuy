import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/sources/product_firebase_service.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/repository/product_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class ProductRepositoryImpl extends ProductRepository {
  @override
  Future<Either> getDoctorChoice(Map<String, dynamic> data) async {
    return await serviceLocator<ProductWooService>()
        .getDoctorChoice(page: data['per_page'] ?? 5);
  }

  @override
  Future<Either> searchProduct(Map<String, dynamic> data) async {
    return await serviceLocator<ProductWooService>().searchProduct(
      title: data['search'] ?? '',
    );
  }

  @override
  Future<Either> getProducts(Map<String, dynamic> data) async {
    return await serviceLocator<ProductWooService>().getProducts(
      page: data['per_page'] ?? 10,
    );
  }

  @override
  Future<Either> getVariations(String productID) async {
    return await serviceLocator<ProductWooService>().getVariations(
      productID: productID,
    );
  }

  @override
  Future<Either> getFavorites() async {
    return await serviceLocator<ProductWooService>().getFavorites();
  }

  @override
  Future<Either> addToFavorites(Map<String, dynamic> data) async {
    return await serviceLocator<ProductWooService>().addToFavorites(
      productID: data['product_id'] ?? 0,
    );
  }

  @override
  Future<Either> removeFromFavorites(int itemID) async {
    return await serviceLocator<ProductWooService>().removeFromFavorites(
      itemID: itemID,
    );
  }
}
