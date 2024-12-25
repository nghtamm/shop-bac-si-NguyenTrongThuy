import 'package:fpdart/fpdart.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/data/models/auth_request.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/data/sources/auth_firebase_service.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/repository/auth_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/service_locator.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  @override
  Future<Either> signUp(AuthenticationRequest authRequest) async {
    return await serviceLocator<AuthenticationFirebaseService>()
        .signUp(authRequest);
  }

  @override
  Future<Either> signIn(AuthenticationRequest authRequest) async {
    return await serviceLocator<AuthenticationFirebaseService>()
        .signIn(authRequest);
  }

  @override
  Future<bool> getAuthState() async {
    return await serviceLocator<AuthenticationFirebaseService>().getAuthState();
  }

  @override
  Future<String> getDisplayName() async {
    return await serviceLocator<AuthenticationFirebaseService>()
        .getDisplayName();
  }

  @override
  Future<Either> resetPassword(String email) async {
    return await serviceLocator<AuthenticationFirebaseService>()
        .resetPassword(email);
  }
}
