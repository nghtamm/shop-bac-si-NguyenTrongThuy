import 'package:get_it/get_it.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/data/repository/auth_repository_impl.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/data/sources/auth_firebase_service.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/repository/auth_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/get_display_name_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/get_auth_state_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/google_sign_in_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/news/data/repository/news_repository_impl.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/news/data/sources/news_firebase_service.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/news/domain/repository/news_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/news/domain/usecase/get_news_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/repository/product_repository_impl.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/sources/product_firebase_service.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/repository/product_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/usecase/get_doctor_choice_usecase.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeDependencies() async {
  serviceLocator.registerSingleton<AuthenticationFirebaseService>(
      AuthenticationFirebaseServiceImpl());

  serviceLocator.registerSingleton<AuthenticationRepository>(
      AuthenticationRepositoryImpl());

  serviceLocator.registerSingleton<SignUpUseCase>(SignUpUseCase());

  serviceLocator.registerSingleton<SignInUseCase>(SignInUseCase());

  serviceLocator.registerSingleton<GetAuthStateUseCase>(GetAuthStateUseCase());

  serviceLocator
      .registerSingleton<GetDisplayNameUseCase>(GetDisplayNameUseCase());

  serviceLocator
      .registerSingleton<ProductFirebaseService>(ProductFirebaseServiceImpl());

  serviceLocator.registerSingleton<ProductRepository>(ProductRepositoryImpl());

  serviceLocator
      .registerSingleton<GetDoctorChoiceUseCase>(GetDoctorChoiceUseCase());

  serviceLocator
      .registerSingleton<ResetPasswordUseCase>(ResetPasswordUseCase());

  serviceLocator.registerSingleton<SignOutUseCase>(SignOutUseCase());

  serviceLocator.registerSingleton<GoogleSignInUseCase>(GoogleSignInUseCase());

  serviceLocator
      .registerSingleton<NewFirebaseService>(NewFirebaseServiceImpl());

  serviceLocator.registerSingleton<NewRepository>(NewRepositoryImpl());

  serviceLocator.registerSingleton<GetNewsUseCase>(GetNewsUseCase());
}
