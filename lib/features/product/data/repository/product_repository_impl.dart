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

  @override
  Future<Either> getAllVariations(String productID) async {
    return await serviceLocator<ProductWooService>().getAllVariations(
      productID: productID,
    );
  }

  @override
  Future<Either<String, bool>> toggleFavorite(ProductEntity product) async {
    var favoriteProductData =
        await serviceLocator<ProductWooService>().toggleFavorite(product);
    return favoriteProductData.fold(
      (l) => Left(l),
      (r) => Right(r), //tra ve trang thai iu thic (true/false)
    );
  }

  @override
  Future<bool> getFavoriteState(String productID) async {
    return await serviceLocator<ProductWooService>()
        .getFavoriteState(productID);
  }

  @override
  Future<Either<String, List<ProductModel>>> getFavoriteProducts() async {
    var favoriteProductData =
        await serviceLocator<ProductWooService>().getFavoriteProducts();
    return favoriteProductData.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
