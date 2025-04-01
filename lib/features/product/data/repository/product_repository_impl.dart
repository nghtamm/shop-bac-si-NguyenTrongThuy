import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/models/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/sources/product_firebase_service.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/repository/product_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class ProductRepositoryImpl extends ProductRepository {
  @override
  Future<Either<String, List<ProductEntity>>> getDoctorChoice() async {
    var productData = await serviceLocator<ProductWooService>().getDoctorChoice();
    return productData.fold(
      (left) => Left(left), //tra ve loi
      (right) => Right(
        right.map((productModel) => productModel.toEntity()).toList(),
      )
    );
  }

  @override
  Future<Either<String, List<ProductEntity>>> getProductByTitle(String title) async {
    var productData = await serviceLocator<ProductWooService>().getProductByTitle(title);
    return productData.fold(
      (left) => Left(left),
      (right) => Right(
        right.map((productModel) => productModel.toEntity()).toList(),
      )
    );
  }

  @override
  Future<Either<String, List<ProductEntity>>> getAllProduct() async {
    var productData = await serviceLocator<ProductWooService>().getAllProduct();
    return productData.fold(
      (left) => Left(left),
      (right) => Right(
        right.map((productModel) => productModel.toEntity()).toList()
      )
    );
  }

  @override
  Future<Either<String, bool>> toggleFavorite(ProductEntity product) async {
    var favoriteProductData = await serviceLocator<ProductWooService>().toggleFavorite(product);
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
  Future<Either<String, List<ProductEntity>>> getFavoriteProducts() async {
    var favoriteProductData = await serviceLocator<ProductWooService>().getFavoriteProducts();
    return favoriteProductData.fold(
      (l) => Left(l),
      (r) => Right(
        r.map((productModel) => productModel.toEntity()).toList()
      )
    );
  }
}