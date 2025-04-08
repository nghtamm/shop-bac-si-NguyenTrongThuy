// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dio/dio.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/local/global_storage.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/network/api_client.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/network/api_endpoints.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/network/api_methods.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/models/favorite_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/models/product_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/repository/product_repository.dart';

abstract class ProductWooService {
  Future<Either> getDoctorChoice({
    required int page,
  });
  Future<Either> searchProduct({
    required String title,
  });
  Future<Either> getAllProduct({
    required int page,
  });
  // Future<Either> getDetailProduct({
  //   required int page,
  // });
  Future<Either> addToFavorites({
    required int productID,
  });
  Future<Either> removeFromFavorites({
    required int itemID,
  });
  Future<Either> getFavoriteState({required String productID});
  Future<Either> getFavoriteProducts({
    required int page,
  });
}

class ProductWooServiceImpl implements ProductWooService {
  @override
  Future<Either> getDoctorChoice({
    required int page,
  }) async {
    try {
      final params = {
        'orderby': 'popularity',
        'per_page': page,
      };

      final response = await serviceLocator<ApiClient>().request(
        endpoint: '${ApiEndpoints.woocommerce}products',
        method: ApiMethods.get,
        queryParameters: params,
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
  Future<Either> searchProduct({
    required String title,
  }) async {
    try {
      final params = {
        'search': title,
      };

      final response = await serviceLocator<ApiClient>().request(
        endpoint: '${ApiEndpoints.woocommerce}products',
        method: ApiMethods.get,
        queryParameters: params,
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
  Future<Either> getAllProduct({
    required int page,
  }) async {
    try {
      final params = {
        'per_page': page,
      };

      final response = await serviceLocator<ApiClient>().request(
        endpoint: '${ApiEndpoints.woocommerce}products',
        method: ApiMethods.get,
        queryParameters: params,
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

  //   @override
  // Future<Either> getDetailProduct({
  //   required int page,
  // }) async {
  //   try {
  //     final params = {
  //       'per_page': page,
  //     };

  //     final response = await serviceLocator<ApiClient>().request(
  //       endpoint: '${ApiEndpoints.woocommerce}products${params['product_id']}',
  //       method: ApiMethods.get,
  //       queryParameters: params,
  //     );

  //     if (response is List) {
  //       List<ProductModel> products = [];
  //       for (var item in response) {
  //         products.add(ProductModel.fromJson(item));
  //       }
  //       return Right(products);
  //     } else {
  //       return const Left("Định dạng dữ liệu không hợp lệ");
  //     }
  //   } catch (e) {
  //     return Left(e.toString());
  //   }
  // }

  @override
  Future<Either> addToFavorites({
    required int productID,
  }) async {
    try {
      final data = {
        'product_id': productID,
      };

      final shareKey = serviceLocator<GlobalStorage>().shareKey!;

      await serviceLocator<ApiClient>().request(
          endpoint: '${ApiEndpoints.tiWishlist}$shareKey/add_product',
          method: ApiMethods.post,
          data: data,
          );

      return const Right('Thêm sản phẩm vào danh sách yêu thích thành công!');
    } catch (e) {
      return Left(
          'Có lỗi xảy ra khi thêm sản phẩm vào danh sách yêu thích: $e');
    }
  }

  @override
  Future<Either> removeFromFavorites({
    required int itemID,
  }) async {
    try {
      await serviceLocator<ApiClient>().request(
        endpoint: '${ApiEndpoints.tiWishlist}remove_product/$itemID',
        method: ApiMethods.get,
      );

      return const Right('Xóa sản phẩm khỏi danh sách yêu thích thành công!');
    } catch (e) {
      return Left('Có lỗi xảy ra khi xóa sản phẩm vào danh sách yêu thích: $e');
    }
  }

  @override
  Future<Either> getFavoriteState({
    required String productID,
  }) async {
    try {
      final shareKey = serviceLocator<GlobalStorage>().shareKey!;
      await serviceLocator<ApiClient>().request(
        endpoint: '${ApiEndpoints.tiWishlist}$shareKey/get_products',
        method: ApiMethods.get,
      );
      return const Right('Thêm sản phẩm vào danh sách yêu thích thành công!');
    } catch (e) {
      return Left(
          'Có lỗi xảy ra khi thêm sản phẩm vào danh sách yêu thích: $e');
    }
  }

//   @override
//   Future<Either> getFavoriteProducts({
//     required int page,
//   }) async {
//     try {

//       final shareKey = serviceLocator<GlobalStorage>().shareKey!;
//       final response = await serviceLocator<ApiClient>().request(
//         endpoint: '${ApiEndpoints.tiWishlist}$shareKey/get_products',
//         method: ApiMethods.get,

//       );
//       if (response is List) {
//         List<FavoriteModel> products =
//             response.map((item) => FavoriteModel.fromJson(item)).toList();
//         return Right(products);
//       } else {
//         return const Left("Định dạng dữ liệu không hợp lệ");
//       }
//     } catch (e) {
//       return Left(e.toString());
//     }
//   }
// }

  @override
Future<Either> getFavoriteProducts({
  required int page,
}) async {
  try {
    final shareKey = serviceLocator<GlobalStorage>().shareKey!;
    final response = await serviceLocator<ApiClient>().request(
      endpoint: '${ApiEndpoints.tiWishlist}$shareKey/get_products',
      method: ApiMethods.get,
    );

    if (response is List) {
      // Lấy danh sách sản phẩm yêu thích từ API
      List<FavoriteModel> favorites = response.map((item) {
        return FavoriteModel.fromJson(item);
      }).toList();

      // Lấy danh sách tất cả sản phẩm để bổ sung dữ liệu
      final allProductsResult =
          await serviceLocator<ProductRepository>().getAllProduct({
        'per_page': 10, // Tải tất cả sản phẩm
      });

      return allProductsResult.fold(
        (failure) => Left(failure),
        (allProducts) {
          // Kết hợp dữ liệu từ ProductModel và FavoriteModel
          List<FavoriteModel> updatedFavorites = favorites.map((favorite) {
            final matchingProduct = allProducts.firstWhere(
              (product) => product.productID == favorite.productID,
              orElse: () => ProductModel(
                productID: 0,
                title: '',
                permalink: '',
                description: '',
                shortDescription: '',
                images: [],
                price: '0',
                regularPrice: null,
                salePrice: null,
                options: [],
                optionsID: [],
                relatedProducts: [],
              ),
            );

            if (matchingProduct.productID != 0) {
              // Bổ sung dữ liệu từ ProductModel
              return FavoriteModel(
                productID: favorite.productID,
                title: matchingProduct.title,
                permalink: matchingProduct.permalink,
                description: matchingProduct.description,
                shortDescription: matchingProduct.shortDescription,
                images: matchingProduct.images.isNotEmpty
                    ? matchingProduct.images
                    : favorite.images,
                price: matchingProduct.price,
                regularPrice: matchingProduct.regularPrice,
                salePrice: matchingProduct.salePrice,
              );
            }
            return favorite;
          }).toList();

          return Right(updatedFavorites);
        },
      );
    } else {
      return const Left("Định dạng dữ liệu không hợp lệ");
    }
  } catch (e) {
    return Left(e.toString());
  }
}
}
