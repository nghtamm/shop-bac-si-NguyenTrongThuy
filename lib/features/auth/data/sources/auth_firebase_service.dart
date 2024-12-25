import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/data/models/auth_request.dart';

abstract class AuthenticationFirebaseService {
  Future<Either> signUp(AuthenticationRequest authRequest);

  Future<Either> signIn(AuthenticationRequest authRequest);

  Future<bool> getAuthState();

  Future<String> getDisplayName();

  Future<Either> resetPassword(String email);

  Future<Either> signOut();

  Future<Either<String, User>> signInWithGoogle();
}

class AuthenticationFirebaseServiceImpl extends AuthenticationFirebaseService {
  @override
  Future<Either> signUp(AuthenticationRequest authRequest) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: authRequest.email,
        password: authRequest.password,
      );
      return const Right('Đăng ký tài khoản thành công!');
    } on FirebaseAuthException catch (err) {
      String errorMessage = '';
      if (err.code == 'email-already-in-use') {
        errorMessage = 'Địa chỉ email đã được sử dụng cho một tài khoản khác.';
      } else if (err.code == 'invalid-email') {
        errorMessage = 'Địa chỉ email không hợp lệ.';
      } else if (err.code == 'weak-password') {
        errorMessage = 'Mật khẩu quá yếu.';
      } else if (err.code == 'too-many-requests') {
        errorMessage = 'Quá nhiều yêu cầu. Vui lòng thử lại sau.';
      } else {
        errorMessage = 'Đã xảy ra lỗi không xác định.';
      }
      return Left(errorMessage);
    }
  }

  @override
  Future<Either> signIn(AuthenticationRequest authRequest) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: authRequest.email,
        password: authRequest.password,
      );
      return const Right(null);
    } on FirebaseAuthException catch (err) {
      String errorMessage = '';
      if (err.code == 'invalid-email') {
        errorMessage = 'Địa chỉ email không hợp lệ.';
      } else if (err.code == 'user-disabled') {
        errorMessage = 'Tài khoản đã bị vô hiệu hóa.';
      } else if (err.code == 'user-not-found') {
        errorMessage = 'Không tìm thấy tài khoản với địa chỉ email này.';
      } else if (err.code == 'wrong-password') {
        errorMessage = 'Mật khẩu không chính xác.';
      } else if (err.code == 'invalid-credential') {
        errorMessage = 'Địa chỉ email hoặc mật khẩu không chính xác.';
      } else {
        errorMessage = 'Đã xảy ra lỗi không xác định.';
      }
      return Left(errorMessage);
    }
  }

  @override
  Future<bool> getAuthState() async {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<String> getDisplayName() async {
    return FirebaseAuth.instance.currentUser?.displayName ?? '';
  }

  @override
  Future<Either> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return const Right('Vui lòng kiểm tra email để đặt lại mật khẩu.');
    } on FirebaseAuthException catch (err) {
      String errorMessage = '';
      if (err.code == 'user-not-found') {
        errorMessage = 'Không tìm thấy tài khoản với địa chỉ email này.';
      } else {
        errorMessage = 'Đã xảy ra lỗi không xác định.';
      }
      return Left(errorMessage);
    }
  }

  @override
  Future<Either> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return const Right('Đăng xuất thành công!');
    } on FirebaseAuthException catch (err) {
      return Left(err.message ?? 'Đã xảy ra lỗi không xác định.');
    }
  }

  @override
  Future<Either<String, User>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return const Left('Đăng nhập bằng Google đã bị hủy.');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        return Right(user);
      } else {
        return const Left('Đăng nhập bằng Google thất bại.');
      }
    } on FirebaseAuthException catch (err) {
      return Left(err.message ?? 'Đã xảy ra lỗi không xác định.');
    }
  }
}
