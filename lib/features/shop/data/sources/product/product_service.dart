import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/local/global_storage.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/network/api_client.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/network/api_endpoints.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/network/api_methods.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/product/product_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/product/variation_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/favorites/wishlist_item_model.dart';

abstract class ProductService {
  Future<Either> getDoctorChoice({
    required int page,
  });
  Future<Either> searchProduct({
    required String title,
  });
  Future<Either> getProducts({
    required int page,
  });
  Future<Either> getVariations({
    required String productID,
  });
  Future<Either> getFavorites();
  Future<Either> addToFavorites({
    required int productID,
  });
  Future<Either> removeFromFavorites({
    required int itemID,
  });
}

class ProductServiceImpl implements ProductService {
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
  Future<Either> getProducts({
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

  @override
  Future<Either> getVariations({
    required String productID,
  }) async {
    try {
      final response = await serviceLocator<ApiClient>().request(
        endpoint: '${ApiEndpoints.woocommerce}products/$productID/variations',
        method: ApiMethods.get,
      );

      if (response is List) {
        List<VariationModel> variations = [];
        for (var item in response) {
          variations.add(VariationModel.fromJson(item));
        }
        return Right(variations.reversed.toList());
      } else {
        return const Left("Định dạng dữ liệu không hợp lệ");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> getFavorites() async {
    try {
      final shareKey = serviceLocator<GlobalStorage>().shareKey;
      final response = await serviceLocator<ApiClient>().request(
        endpoint: '${ApiEndpoints.tiWishlist}$shareKey/get_products',
        method: ApiMethods.get,
      );

      if (response is List) {
        final favorites =
            response.map((e) => WishlistItemModel.fromJson(e)).toList();
        final favoriteIDs = favorites.map((e) => e.productID).toSet();
        final products = await getProducts(page: 100);
        return await products.fold(
          (left) => Left(left),
          (right) {
            final filtered = right
                .where(
                  (product) => favoriteIDs.contains(
                    product.productID,
                  ),
                )
                .toList();
            return Right(
              {
                'products': filtered,
                'favorites': favorites,
              },
            );
          },
        );
      } else {
        return const Left(
          "Đã có lỗi không xác định xảy ra trong quá trình lấy danh sách yêu thích",
        );
      }
    } catch (error) {
      return Left(
        error.toString(),
      );
    }
  }

  @override
  Future<Either> addToFavorites({
    required int productID,
  }) async {
    try {
      final shareKey = serviceLocator<GlobalStorage>().shareKey;
      final data = {
        'product_id': productID,
      };

      await serviceLocator<ApiClient>().request(
        endpoint: '${ApiEndpoints.tiWishlist}$shareKey/add_product',
        method: ApiMethods.post,
        data: data,
      );

      return const Right('Thêm sản phẩm vào danh sách yêu thích thành công!');
    } catch (error) {
      return Left(
        error.toString(),
      );
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
    } catch (error) {
      return Left(
        error.toString(),
      );
    }
  }
}
