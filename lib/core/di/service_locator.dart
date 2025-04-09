import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/local/global_storage.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/network/api_client.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/data/repository/auth_repository_impl.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/data/sources/auth_service.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/repository/auth_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/authenticate_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/user_validate_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/google_sign_in_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/repository/order/order_repository_impl.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/sources/order/order_service.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/repository/order/order_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/usecase/order/add_to_cart_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/data/repository/news_repository_impl.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/data/sources/news_firebase_service.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/domain/repository/news_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/domain/usecase/get_news_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/usecase/order/dispose_cart_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/usecase/order/display_cart_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/usecase/order/get_order_history_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/usecase/order/order_registration_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/usecase/order/remove_from_cart_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/repository/product/product_repository_impl.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/sources/product/product_service.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/repository/product/product_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/usecase/product/add_to_favorites_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/usecase/product/get_favorites_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/usecase/product/get_products_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/usecase/product/get_variations_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/usecase/product/get_doctor_choice_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/usecase/product/remove_from_favorites_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/domain/usecase/product/search_product_usecase.dart';

final serviceLocator = GetIt.instance;
final hive = GlobalStorageImpl();

Future<void> initializeDependencies() async {
  // HIVE
  await hive.init();
  serviceLocator.registerSingleton<GlobalStorage>(hive);

  // NETWORK
  serviceLocator.registerLazySingleton(
    () => Dio(),
  );
  serviceLocator.registerLazySingleton<ApiClient>(
    () => ApiClient(
      serviceLocator<Dio>(),
      serviceLocator<GlobalStorage>(),
    ),
  );

  /* FEATURES */
  // REPOSITORIES
  serviceLocator.registerSingleton<AuthenticationRepository>(
    AuthenticationRepositoryImpl(),
  );

  serviceLocator.registerSingleton<OrderRepository>(
    OrderRepositoryImpl(),
  );

  serviceLocator.registerSingleton<ProductRepository>(
    ProductRepositoryImpl(),
  );

  serviceLocator.registerSingleton<NewRepository>(
    NewRepositoryImpl(),
  );

  // SERVICES
  serviceLocator.registerSingleton<AuthenticationService>(
    AuthenticationServiceImpl(),
  );

  serviceLocator.registerSingleton<ProductService>(
    ProductServiceImpl(),
  );

  serviceLocator.registerSingleton<OrderService>(
    OrderServiceImpl(),
  );

  serviceLocator.registerSingleton<NewFirebaseService>(
    NewFirebaseServiceImpl(),
  );

  // USECASES
  serviceLocator.registerSingleton<SignUpUseCase>(
    SignUpUseCase(),
  );

  serviceLocator.registerSingleton<AuthenticateUseCase>(
    AuthenticateUseCase(),
  );

  serviceLocator.registerSingleton<SignInUseCase>(
    SignInUseCase(),
  );

  serviceLocator.registerSingleton<UserValidateUseCase>(
    UserValidateUseCase(),
  );

  serviceLocator.registerSingleton<GetDoctorChoiceUseCase>(
    GetDoctorChoiceUseCase(),
  );

  serviceLocator.registerSingleton<ResetPasswordUseCase>(
    ResetPasswordUseCase(),
  );

  serviceLocator.registerSingleton<AddToCartUseCase>(
    AddToCartUseCase(),
  );

  serviceLocator.registerSingleton<SignOutUseCase>(
    SignOutUseCase(),
  );

  serviceLocator.registerSingleton<GoogleSignInUseCase>(
    GoogleSignInUseCase(),
  );

  serviceLocator.registerSingleton<GetNewsUseCase>(
    GetNewsUseCase(),
  );

  serviceLocator.registerSingleton<SearchProductUseCase>(
    SearchProductUseCase(),
  );

  serviceLocator.registerSingleton<GetProductsUseCase>(
    GetProductsUseCase(),
  );

  serviceLocator.registerSingleton<DisplayCartUseCase>(
    DisplayCartUseCase(),
  );

  serviceLocator.registerSingleton<RemoveFromCartUseCase>(
    RemoveFromCartUseCase(),
  );

  serviceLocator.registerSingleton<OrderRegistrationUseCase>(
    OrderRegistrationUseCase(),
  );

  serviceLocator.registerSingleton<DisposeCartUseCase>(
    DisposeCartUseCase(),
  );

  serviceLocator.registerSingleton<GetOrderHistoryUseCase>(
    GetOrderHistoryUseCase(),
  );

  serviceLocator.registerSingleton<GetVariationsUseCase>(
    GetVariationsUseCase(),
  );

  serviceLocator.registerSingleton<GetFavoritesUseCase>(
    GetFavoritesUseCase(),
  );

  serviceLocator.registerSingleton<AddToFavoritesUseCase>(
    AddToFavoritesUseCase(),
  );

  serviceLocator.registerSingleton<RemoveFromFavoritesUseCase>(
    RemoveFromFavoritesUseCase(),
  );
}
