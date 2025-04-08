import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/models/product_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/sources/product_firebase_service.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product_entity.dart';
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
  Future<Either> getAllProduct(Map<String, dynamic> data) async {
    return await serviceLocator<ProductWooService>().getAllProduct(
      page: data['per_page'] ?? 10,
    );
  }

  //   @override
  // Future<Either> getDetailProduct(Map<String, dynamic> data) async {
  //   return await serviceLocator<ProductWooService>().getAllProduct(
  //     page: data['per_page'] ?? 1,
  //   );
  // }

  @override
  Future<Either> addToFavorites(Map<String, dynamic> data) async {
    return await serviceLocator<ProductWooService>().addToFavorites(
      productID: data['product_id'] ?? 0,
    );
  }

    @override
  Future<Either> removeFromFavorites(Map<String, dynamic> data) async {
    return await serviceLocator<ProductWooService>().removeFromFavorites(
      itemID: data['item_id'] ?? 0,
    );
  }

  @override
  Future<Either> getFavoriteState(Map<String, dynamic> data) async {
    return await serviceLocator<ProductWooService>()
        .getFavoriteState(
      productID: data['product_id'].toString() ,
        );
  }

  @override
  Future<Either> getFavoriteProducts(Map<String, dynamic> data) async {
    return await serviceLocator<ProductWooService>().getFavoriteProducts(
      page: data['per_page'] ?? 10,
    );
  }
}
