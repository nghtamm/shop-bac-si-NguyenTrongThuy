import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/local/global_storage.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/data/sources/auth_service.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/repository/auth_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  @override
  Future<Either> signUp(Map<String, dynamic> data) {
    return serviceLocator<AuthenticationService>().signUp(
      restRoute: data['rest_route'] ?? '/simple-jwt-login/v1/users',
      email: data['email'] ?? '',
      password: data['password'] ?? '',
      authKey: data['AUTH_KEY'] ?? dotenv.env['JWT_SUBSCRIBER_AUTH_KEY'],
      firstName: data['first_name'] ?? '',
      lastName: data['last_name'] ?? '',
      displayName: data['display_name'] ?? '',
      userLogin: data['user_login'] ?? '',
      userNicename: data['user_nicename'] ?? '',
    );
  }

  @override
  Future<Either> authenticate(Map<String, dynamic> data) {
    return serviceLocator<AuthenticationService>().authenticate(
      restRoute: data['rest_route'] ?? '/simple-jwt-login/v1/auth',
      email: data['email'] ?? '',
      password: data['password'] ?? '',
    );
  }

  @override
  Future<Either> signIn(Map<String, dynamic> data) {
    return serviceLocator<AuthenticationService>().signIn(
      restRoute: data['rest_route'] ?? '/simple-jwt-login/v1/autologin',
      jwt: data['jwt'] ?? serviceLocator<GlobalStorage>().accessToken ?? '',
    );
  }

  @override
  Future<Either> userValidate(Map<String, dynamic> data) async {
    return await serviceLocator<AuthenticationService>().userValidate(
      restRoute: data['rest_route'] ?? '/simple-jwt-login/v1/auth/validate',
      jwt: data['jwt'] ?? serviceLocator<GlobalStorage>().accessToken ?? '',
    );
  }

  @override
  Future<Either> signOut() async {
    return await serviceLocator<AuthenticationService>().signOut();
  }

  @override
  Future<Either> resetPassword(Map<String, dynamic> data) async {
    return await serviceLocator<AuthenticationService>().resetPassword(
      restRoute:
          data['rest_route'] ?? '/simple-jwt-login/v1/user/reset_password',
      email: data['email'] ?? '',
    );
  }

  @override
  Future<Either> googleSignIn() async {
    return await serviceLocator<AuthenticationService>().googleSignIn();
  }
}
