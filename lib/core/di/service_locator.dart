import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/network/api_client.dart';
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
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/repository/order.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/sources/order_firebase_service.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/repository/order.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/usecases/add_to_cart.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/data/repository/news_repository_impl.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/data/sources/news_firebase_service.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/domain/repository/news_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/domain/usecase/get_news_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/usecases/dispose_cart_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/usecases/get_cart_products.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/usecases/get_orders_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/usecases/order_registration.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/usecases/remove_cart_products.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/repository/product_repository_impl.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/sources/product_firebase_service.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/repository/product_repository.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/usecase/get_all_product_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/usecase/get_doctor_choice_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/usecase/get_favorite_products_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/usecase/get_favorite_state_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/usecase/get_product_by_title_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/usecase/toggle_favorite_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/api_client_example/product_repo.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/api_client_example/product_repo_impl.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/api_client_example/product_service.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/api_client_example/product_use_case.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeDependencies() async {
  // NETWORK
  serviceLocator.registerLazySingleton(
    () => Dio(),
  );
  serviceLocator.registerLazySingleton<ApiClient>(
    () => ApiClient(
      serviceLocator<Dio>(),
    ),
  );

  // DI FOR APICLIENT EXAMPLES
  serviceLocator.registerSingleton<ProductRepo>(
    ProductRepoImpl(),
  );

  serviceLocator.registerSingleton<ProductService>(
    ProductServiceImpl(),
  );

  serviceLocator.registerSingleton<ProductUseCase>(
    ProductUseCase(),
  );

  // SERVICES
  serviceLocator.registerSingleton<AuthenticationFirebaseService>(
    AuthenticationFirebaseServiceImpl(),
  );

  serviceLocator.registerSingleton<AuthenticationRepository>(
    AuthenticationRepositoryImpl(),
  );

  serviceLocator.registerSingleton<SignUpUseCase>(
    SignUpUseCase(),
  );

  serviceLocator.registerSingleton<SignInUseCase>(
    SignInUseCase(),
  );

  serviceLocator.registerSingleton<GetAuthStateUseCase>(
    GetAuthStateUseCase(),
  );

  serviceLocator.registerSingleton<GetDisplayNameUseCase>(
    GetDisplayNameUseCase(),
  );

  serviceLocator.registerSingleton<ProductWooService>(
    ProductWooServiceImpl(),
  );

  serviceLocator.registerSingleton<OrderFirebaseService>(
    OrderFirebaseServiceImpl(),
  );

  serviceLocator.registerSingleton<OrderRepository>(
    OrderRepositoryImpl(),
  );

  serviceLocator.registerSingleton<ProductRepository>(
    ProductRepositoryImpl(),
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

  serviceLocator.registerSingleton<NewFirebaseService>(
    NewFirebaseServiceImpl(),
  );

  serviceLocator.registerSingleton<NewRepository>(
    NewRepositoryImpl(),
  );

  serviceLocator.registerSingleton<GetNewsUseCase>(
    GetNewsUseCase(),
  );

  serviceLocator.registerSingleton<GetProductByTitleUseCase>(
    GetProductByTitleUseCase(),
  );

  serviceLocator.registerSingleton<GetAllProductUseCase>(
    GetAllProductUseCase(),
  );

  serviceLocator.registerSingleton<ToggleFavoriteUseCase>(
    ToggleFavoriteUseCase(),
  );

  serviceLocator.registerSingleton<GetFavoriteStateUseCase>(
    GetFavoriteStateUseCase(),
  );

  serviceLocator.registerSingleton<GetFavoriteProductsUseCase>(
    GetFavoriteProductsUseCase(),
  );

  serviceLocator.registerSingleton<GetCartProductsUseCase>(
    GetCartProductsUseCase(),
  );

  serviceLocator.registerSingleton<RemoveCartProductUseCase>(
    RemoveCartProductUseCase(),
  );

  serviceLocator.registerSingleton<OrderRegistrationUseCase>(
    OrderRegistrationUseCase(),
  );

  serviceLocator.registerSingleton<DisposeCartUseCase>(
    DisposeCartUseCase(),
  );

  serviceLocator.registerSingleton<GetOrdersUseCase>(
    GetOrdersUseCase(),
  );
}
