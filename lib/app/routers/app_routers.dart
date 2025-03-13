import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/pages/authentication.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/pages/forgot_password.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/pages/sign_in.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/pages/sign_up.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/cart/views/pages/cart.dart';
<<<<<<< HEAD
import 'package:shop_bacsi_nguyentrongthuy/features/chatgpt_bot/views/pages/ai_chat.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/checkout/views/pages/checkout.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/favorites/views/pages/my_favorites.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/get_started/views/bloc/auth_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/get_started/views/bloc/auth_state.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/get_started/views/pages/get_started.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/pages/home.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/entities/order.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/entities/product_ordered.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/views/pages/order_detail.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/views/pages/order_history.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/views/pages/order_items.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/views/pages/order_placed.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/pages/all_product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/pages/product_detail.dart';
=======
import 'package:shop_bacsi_nguyentrongthuy/features/favorites/views/pages/my_favorites.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/medical_chatbot/views/pages/chatbot.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/cart/views/pages/checkout.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/bloc/auth_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/onboarding/views/pages/onboarding.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/pages/home.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/entities/order.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/entities/product_ordered.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/views/pages/order_details.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/views/pages/order_history.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/views/pages/order_items.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/cart/views/pages/order_placed.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/pages/all_products.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/pages/product_details.dart';
>>>>>>> nghtamm2003/refactor
import 'package:shop_bacsi_nguyentrongthuy/features/search/views/pages/search.dart';

class AppRouters {
  static final GoRouter router = GoRouter(
    initialLocation: RoutersName.root,
    routes: [
<<<<<<< HEAD
      GoRoute(
        path: RoutersName.root,
        builder: (context, state) {
          final authState = context.read<AuthenticationCubit>().state;

          if (authState is Authenticated) {
            return HomePage(displayName: authState.displayName);
=======
      // ROOT
      GoRoute(
        path: RoutersName.root,
        builder: (context, state) {
          final state = context.read<AuthBloc>().state;

          if (state is Authenticated) {
            return HomePage(
              displayName: state.displayName,
            );
>>>>>>> nghtamm2003/refactor
          } else {
            return const GetStartedPage();
          }
        },
      ),
<<<<<<< HEAD
      GoRoute(
        path: RoutersName.getStarted,
        builder: (context, state) => const GetStartedPage(),
      ),
=======

      // MODULES
      // Onboarding
      GoRoute(
        path: RoutersName.onboarding,
        builder: (context, state) => const GetStartedPage(),
      ),

      // Authentication
>>>>>>> nghtamm2003/refactor
      GoRoute(
        path: RoutersName.authentication,
        builder: (context, state) => const AuthenticationPage(),
      ),
      GoRoute(
        path: RoutersName.signUp,
        builder: (context, state) => SignUpPage(),
      ),
      GoRoute(
        path: RoutersName.signIn,
        builder: (context, state) => SignInPage(),
      ),
      GoRoute(
        path: RoutersName.forgotPassword,
        builder: (context, state) => ForgotPasswordPage(),
      ),
<<<<<<< HEAD
=======

      // Home
>>>>>>> nghtamm2003/refactor
      GoRoute(
        path: RoutersName.homepage,
        builder: (context, state) {
          final displayName = state.extra as String;
          return HomePage(
            displayName: displayName,
          );
        },
      ),
<<<<<<< HEAD
=======

      // Cart
      GoRoute(
        path: RoutersName.cart,
        builder: (context, state) => const CartPage(),
      ),
>>>>>>> nghtamm2003/refactor
      GoRoute(
        path: RoutersName.checkout,
        builder: (context, state) {
          final products = state.extra as List<ProductOrderedEntity>;
          return CheckoutPage(
            products: products,
          );
        },
      ),
      GoRoute(
        path: RoutersName.orderPlaced,
        builder: (context, state) => const OrderPlacedPage(),
      ),
<<<<<<< HEAD
=======

      // Favorites
      GoRoute(
        path: RoutersName.myFavorites,
        builder: (context, state) => const MyFavoritesPage(),
      ),

      // Medical Chatbot
      GoRoute(
        path: RoutersName.chatbot,
        builder: (context, state) => const Chatbot(),
      ),

      // Product
>>>>>>> nghtamm2003/refactor
      GoRoute(
        path: RoutersName.allProducts,
        builder: (context, state) => const AllProductPage(),
      ),
      GoRoute(
        path: RoutersName.productDetails,
        builder: (context, state) {
          final productEntity = state.extra as ProductEntity;
          return ProductDetailPage(
            productEntity: productEntity,
          );
        },
      ),
<<<<<<< HEAD
      GoRoute(
        path: RoutersName.myFavorites,
        builder: (context, state) => const MyFavoritesPage(),
      ),
      GoRoute(
        path: RoutersName.cart,
        builder: (context, state) => const CartPage(),
      ),
=======

      // Order
>>>>>>> nghtamm2003/refactor
      GoRoute(
        path: RoutersName.orderHistory,
        builder: (context, state) => const OrderHistoryPage(),
      ),
      GoRoute(
<<<<<<< HEAD
        path: RoutersName.aiChat,
        builder: (context, state) => const AiChat(),
      ),
      GoRoute(
        path: RoutersName.search,
        builder: (context, state) => SearchPage(),
      ),
      GoRoute(
=======
>>>>>>> nghtamm2003/refactor
        path: RoutersName.orderItems,
        builder: (context, state) {
          final products = state.extra as List<ProductOrderedEntity>;
          return OrderItemsPage(
            products: products,
          );
        },
      ),
      GoRoute(
        path: RoutersName.orderDetails,
        builder: (context, state) {
          final orderEntity = state.extra as OrderEntity;
<<<<<<< HEAD
          return OrderDetailPage(
=======
          return OrderDetailsPage(
>>>>>>> nghtamm2003/refactor
            orderEntity: orderEntity,
          );
        },
      ),
<<<<<<< HEAD
=======

      // Search
      GoRoute(
        path: RoutersName.search,
        builder: (context, state) => SearchPage(),
      ),
>>>>>>> nghtamm2003/refactor
    ],
  );
}
