import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/sources/product/product_service.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/repository/product/product_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class ProductRepositoryImpl extends ProductRepository {
  @override
  Future<Either> getDoctorChoice(Map<String, dynamic> data) async {
    return await serviceLocator<ProductService>()
        .getDoctorChoice(page: data['per_page'] ?? 5);
  }

  @override
  Future<Either> searchProduct(Map<String, dynamic> data) async {
    return await serviceLocator<ProductService>().searchProduct(
      title: data['search'] ?? '',
    );
  }

  @override
  Future<Either> getProducts(Map<String, dynamic> data) async {
    return await serviceLocator<ProductService>().getProducts(
      perPage: data['per_page'] ?? 8,
      page: data['page'] ?? 1,
    );
  }

  @override
  Future<Either> getVariations(String productID) async {
    return await serviceLocator<ProductService>().getVariations(
      productID: productID,
    );
  }

  @override
  Future<Either> getFavorites() async {
    return await serviceLocator<ProductService>().getFavorites();
  }

  @override
  Future<Either> addToFavorites(Map<String, dynamic> data) async {
    return await serviceLocator<ProductService>().addToFavorites(
      productID: data['product_id'] ?? 0,
    );
  }

  @override
  Future<Either> removeFromFavorites(int itemID) async {
    return await serviceLocator<ProductService>().removeFromFavorites(
      itemID: itemID,
    );
  }
}
