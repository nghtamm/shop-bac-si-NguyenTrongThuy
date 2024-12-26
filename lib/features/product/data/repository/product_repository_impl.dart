import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/models/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/sources/product_firebase_service.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/repository/product_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/service_locator.dart';

class ProductRepositoryImpl extends ProductRepository {
  @override
  Future<Either> getDoctorChoice() async {
    var productData =
        await serviceLocator<ProductFirebaseService>().getDoctorChoice();
    return productData.fold((left) {
      return Left(left);
    }, (right) {
      return Right(List.from(right)
          .map((e) => ProductModel.fromMap(e).toEntity())
          .toList());
    });
  }

  @override
  Future<Either> getProductByTitle(String title) async {
    var productData =
        await serviceLocator<ProductFirebaseService>().getProductByTitle(title);
    return productData.fold((left) {
      return Left(left);
    }, (right) {
      return Right(List.from(right)
          .map((e) => ProductModel.fromMap(e).toEntity())
          .toList());
    });
  }

  @override
  Future<Either> getAllProduct() async {
    var productData =
        await serviceLocator<ProductFirebaseService>().getAllProduct();
    return productData.fold((left) {
      return Left(left);
    }, (right) {
      return Right(List.from(right)
          .map((e) => ProductModel.fromMap(e).toEntity())
          .toList());
    });
  }

  @override
  Future<Either> toggleFavorite(ProductEntity product) async {
    var favoriteProductsData =
        await serviceLocator<ProductFirebaseService>().toggleFavorite(product);
    return favoriteProductsData.fold((left) {
      return Left(left);
    }, (right) {
      return Right(right);
    });
  }

  @override
  Future<bool> getFavoriteState(String productID) async {
    return await serviceLocator<ProductFirebaseService>()
        .getFavoriteState(productID);
  }

  @override
  Future<Either> getFavoriteProducts() async {
    var favoriteProductsData =
        await serviceLocator<ProductFirebaseService>().getFavoriteProducts();
    return favoriteProductsData.fold((error) {
      return Left(error);
    }, (data) {
      return Right(List.from(data)
          .map((e) => ProductModel.fromMap(e).toEntity())
          .toList());
    });
  }
}
