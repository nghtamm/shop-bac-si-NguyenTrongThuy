import 'package:fpdart/fpdart.dart';

abstract class AuthenticationRepository {
  Future<Either> signUp(Map<String, dynamic> data);
  Future<Either> authenticate(Map<String, dynamic> data);
  Future<Either> signIn(Map<String, dynamic> data);
  Future<Either> userValidate(Map<String, dynamic> data);
  Future<Either> signOut();
  Future<Either> resetPassword(Map<String, dynamic> data);
  Future<Either> googleSignIn();
}
