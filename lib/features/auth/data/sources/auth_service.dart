import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/local/global_storage.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/network/api_client.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/network/api_endpoints.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/network/api_methods.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/data/models/user_model.dart';

abstract class AuthenticationService {
  Future<Either> signUp({
    required String restRoute,
    required String email,
    required String password,
    required String authKey,
    required String firstName,
    required String lastName,
    required String displayName,
    required String userLogin,
    required String userNicename,
  });
  Future<Either> authenticate({
    required String restRoute,
    required String email,
    required String password,
  });
  Future<Either> signIn({
    required String restRoute,
    required String jwt,
  });
  Future<Either> userValidate({
    required String restRoute,
    required String jwt,
  });
  Future<Either> signOut();
  Future<Either> resetPassword({
    required String restRoute,
    required String email,
  });
  Future<Either> googleSignIn();
}

class AuthenticationServiceImpl extends AuthenticationService {
  @override
  Future<Either> signUp({
    required String restRoute,
    required String email,
    required String password,
    required String authKey,
    required String firstName,
    required String lastName,
    required String displayName,
    required String userLogin,
    required String userNicename,
  }) async {
    try {
      final params = {
        'rest_route': restRoute,
        'email': email,
        'password': password,
        'AUTH_KEY': authKey,
        'first_name': firstName,
        'last_name': lastName,
        'display_name': displayName,
        'user_login': userLogin,
        'user_nicename': userNicename,
      };

      await serviceLocator<ApiClient>().request(
        endpoint: ApiEndpoints.baseURL,
        method: ApiMethods.post,
        queryParameters: params,
      );

      return const Right('Đăng ký tài khoản thành công!');
    } catch (error) {
      return const Left(
        'Vui lòng kiểm tra lại thông tin cá nhân của bạn hoặc thử lại sau.',
      );
    }
  }

  @override
  Future<Either> authenticate({
    required String restRoute,
    required String email,
    required String password,
  }) async {
    try {
      final params = {
        'rest_route': restRoute,
        'email': email,
        'password': password,
      };

      final response = await serviceLocator<ApiClient>().request(
        endpoint: ApiEndpoints.baseURL,
        method: ApiMethods.post,
        queryParameters: params,
      );

      final String token = (response as Map<String, dynamic>)['data']['jwt'];
      await serviceLocator<GlobalStorage>().saveToken(token);

      return Right(token);
    } catch (error) {
      return Left(error.toString());
    }
  }

  @override
  Future<Either> signIn({
    required String restRoute,
    required String jwt,
  }) async {
    try {
      final params = {
        'rest_route': restRoute,
        'JWT': jwt,
      };

      await serviceLocator<ApiClient>().request(
        endpoint: ApiEndpoints.baseURL,
        method: ApiMethods.get,
        queryParameters: params,
        useJWT: true,
      );

      return const Right('Đăng nhập thành công!');
    } catch (error) {
      return const Left(
        'Vui lòng kiểm tra lại thông tin đăng nhập của bạn hoặc thử lại sau.',
      );
    }
  }

  @override
  Future<Either> userValidate({
    required String restRoute,
    required String jwt,
  }) async {
    try {
      final params = {
        'rest_route': restRoute,
        'JWT': jwt,
      };

      final response = await serviceLocator<ApiClient>().request(
        endpoint: ApiEndpoints.baseURL,
        method: ApiMethods.get,
        queryParameters: params,
        useJWT: true,
      );

      if (response is Map<String, dynamic>) {
        final data = response['data']['user'];
        if (data is Map<String, dynamic>) {
          final parsed = UserModel.fromJson(data);
          await serviceLocator<GlobalStorage>().saveUser(parsed);

          final shareKeyResponse = await serviceLocator<ApiClient>().request(
            endpoint: '${ApiEndpoints.tiWishlist}get_by_user/${parsed.id}',
            method: ApiMethods.get,
          );

          if (shareKeyResponse is List) {
            final firstItem =
                shareKeyResponse.isNotEmpty ? shareKeyResponse.first : null;

            if (firstItem is Map<String, dynamic> &&
                firstItem.containsKey('share_key')) {
              final shareKey = firstItem['share_key'];
              await serviceLocator<GlobalStorage>().saveShareKey(shareKey);
            }
          }

          return Right(parsed);
        }
      }

      return const Left(
        'Không tìm thấy thông tin người dùng',
      );
    } catch (error) {
      return const Left(
        'Đã xảy ra lỗi không xác định khi xác thực. Vui lòng thử lại sau.',
      );
    }
  }

  @override
  Future<Either> signOut() async {
    try {
      await GoogleSignIn().signOut();

      await serviceLocator<GlobalStorage>().clearToken();
      await serviceLocator<GlobalStorage>().clearUser();
      await serviceLocator<GlobalStorage>().clearShareKey();
      await serviceLocator<GlobalStorage>().clearCart();

      return const Right('Đăng xuất thành công!');
    } catch (error) {
      return const Left(
        'Đăng xuất không thành công!',
      );
    }
  }

  @override
  Future<Either> resetPassword({
    required String restRoute,
    required String email,
  }) async {
    try {
      final params = {
        'rest_route': restRoute,
        'email': email,
      };

      await serviceLocator<ApiClient>().request(
        endpoint: ApiEndpoints.baseURL,
        method: ApiMethods.post,
        queryParameters: params,
      );

      return const Right(
        'Yêu cầu đặt lại mật khẩu đã được gửi đến email của bạn!',
      );
    } catch (error) {
      return const Left(
        'Gửi yêu cầu đặt lại mật khẩu thất bại!',
      );
    }
  }

  @override
  Future<Either> googleSignIn() async {
    try {
      GoogleSignIn(
        scopes: ['email', 'profile'],
        clientId: dotenv.env['GOOGLE_CLIENT_ID'],
      );

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        await GoogleSignIn().signOut();
        await serviceLocator<GlobalStorage>().clearToken();

        return const Left('Đăng nhập bằng Google đã bị hủy.');
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? idToken = googleAuth.idToken;
      if (idToken == null) {
        await GoogleSignIn().signOut();
        await serviceLocator<GlobalStorage>().clearToken();

        return const Left(
          "Đã xãy ra lỗi không xác định khi lấy 'id_token' từ Google.",
        );
      }

      final response = await serviceLocator<ApiClient>().request(
        endpoint: ApiEndpoints.baseURL,
        method: ApiMethods.post,
        queryParameters: {
          'rest_route': '/simple-jwt-login/v1/oauth/token',
          'provider': 'google',
          'id_token': idToken,
        },
      );

      final tokenJWT = response['data']['jwt'];
      await serviceLocator<GlobalStorage>().saveToken(tokenJWT);

      return const Right('Đăng nhập bằng Google thành công!');
    } on DioException catch (error) {
      if (error.response?.statusCode == 400) {
        GoogleSignIn(
          scopes: ['email', 'profile'],
          clientId: dotenv.env['GOOGLE_CLIENT_ID'],
        );

        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        final userData = {
          'email': googleUser?.email,
          'display_name': googleUser?.displayName ?? '',
          'first_name': (googleUser?.displayName != null &&
                  googleUser!.displayName!.split(' ').length > 1)
              ? googleUser.displayName!.split(' ').sublist(1).join(' ')
              : '',
          'last_name': googleUser?.displayName?.split(' ').first ?? '',
          'user_login': googleUser?.email.split('@').first,
          'user_nicename': googleUser?.email.split('@').first,
        };
        return Right(userData);
      }

      return Left(
        error.response?.data['data']['message'],
      );
    } catch (error) {
      await GoogleSignIn().signOut();
      await serviceLocator<GlobalStorage>().clearToken();

      return const Left(
        'Đăng nhập bằng Google thất bại!',
      );
    }
  }
}
