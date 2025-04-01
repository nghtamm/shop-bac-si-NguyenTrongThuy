// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dio/dio.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/network/api_client.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/network/api_endpoints.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/network/api_methods.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/models/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';

abstract class ProductWooService {
  Future<Either<String, List<ProductModel>>> getDoctorChoice();
  Future<Either<String, List<ProductModel>>> getProductByTitle(String title);
  Future<Either<String, List<ProductModel>>> getAllProduct();
  Future<Either<String, bool>> toggleFavorite(ProductEntity product);
  Future<bool> getFavoriteState(String productID);
  Future<Either<String, List<ProductModel>>> getFavoriteProducts();
}

class ProductWooServiceImpl implements ProductWooService {
  @override
  Future<Either<String, List<ProductModel>>> getDoctorChoice() async {
    try {
      final response = await serviceLocator<ApiClient>().request(
        endpoint: '${ApiEndpoints.woocommerce}products',
        method: ApiMethods.get,
        data: {
          'orderby': 'popularity',
          'per_page': 10,
        },
      );
      if (response is List) {
        List<ProductModel> products = [];
        for (var item in response) {
          products.add(ProductModel.fromJson(item));
        }
        return Right(products);
      } else {
        return const Left("Định dạng dữ liệu không hợp lệ");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ProductModel>>> getProductByTitle(
      String title) async {
    try {
      final response = await serviceLocator<ApiClient>().request(
        endpoint: '${ApiEndpoints.woocommerce}products',
        method: ApiMethods.get,
        data: {'search': title},
      );
      if (response is List) {
        List<ProductModel> products = [];
        for (var item in response) {
          products.add(ProductModel.fromJson(item));
        }
        return Right(products);
      } else {
        return const Left("Định dạng dữ liệu không hợp lệ");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ProductModel>>> getAllProduct() async {
    try {
      final response = await serviceLocator<ApiClient>().request(
        endpoint: '${ApiEndpoints.woocommerce}products',
        method: ApiMethods.get,
        data: {
          'per_page': 20,
        },
      );
      if (response is List) {
        List<ProductModel> products = [];
        for (var item in response) {
          products.add(ProductModel.fromJson(item));
        }
        return Right(products);
      } else {
        return const Left("Định dạng dữ liệu không hợp lệ");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> toggleFavorite(
      ProductEntity product) async {
    try {
      final response = await serviceLocator<ApiClient>().request(
        endpoint: '${ApiEndpoints.tiWishlist}',
        method: ApiMethods.post,
        data: {
          'product_id': product.productID,
        },
      );
      if (response is Map<String, dynamic> && response['status'] == 'success') {
        return const Right(true);
      } else {
        return const Left("Không thể cập nhật trạng thái yêu thích");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<bool> getFavoriteState(String productID) async {
    try {
      final response = await serviceLocator<ApiClient>().request(
        endpoint: '${ApiEndpoints.tiWishlist}$productID',
        method: ApiMethods.get,
      );
      if (response is Map<String, dynamic> && response['is_favorite'] != null) {
        //chua lay dc sharekey de xem truong nay ten gi
        return response['is_favorite'] as bool;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }

  @override
  Future<Either<String, List<ProductModel>>> getFavoriteProducts() async {
    try {
      final response = await serviceLocator<ApiClient>().request(
        endpoint: '${ApiEndpoints.tiWishlist}',
        method: ApiMethods.get,
      );
      if (response is List) {
        List<ProductModel> products =
            response.map((item) => ProductModel.fromJson(item)).toList();
        return Right(products);
      } else {
        return const Left("Định dạng dữ liệu không hợp lệ");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
