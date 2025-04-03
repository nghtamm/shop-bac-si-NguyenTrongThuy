import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/pages/authentication.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/pages/forgot_password.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/pages/sign_in.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/pages/sign_up.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/cart/views/pages/cart.dart';
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
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/models/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/pages/all_products.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/pages/product_details.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/search/views/pages/search.dart';

class AppRouters {
  static final GoRouter router = GoRouter(
    initialLocation: RoutersName.root,
    routes: [
      // ROOT
      GoRoute(
        path: RoutersName.root,
        builder: (context, state) {
          final state = context.read<AuthBloc>().state;

          if (state is Authenticated) {
            return HomePage(
              displayName: state.displayName,
            );
          } else {
            return const GetStartedPage();
          }
        },
      ),

      // MODULES
      // Onboarding
      GoRoute(
        path: RoutersName.onboarding,
        builder: (context, state) => const GetStartedPage(),
      ),

      // Authentication
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

      // Home
      GoRoute(
        path: RoutersName.homepage,
        builder: (context, state) {
          final displayName = state.extra as String;
          return HomePage(
            displayName: displayName,
          );
        },
      ),

      // Cart
      GoRoute(
        path: RoutersName.cart,
        builder: (context, state) => const CartPage(),
      ),
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
      GoRoute(
        path: RoutersName.allProducts,
        builder: (context, state) => const AllProductPage(),
      ),
      GoRoute(
        path: RoutersName.productDetails,
        builder: (context, state) {
          final productModel = state.extra as ProductModel;
          return ProductDetailPage(
            productModel: productModel,
          );
        },
      ),

      // Order
      GoRoute(
        path: RoutersName.orderHistory,
        builder: (context, state) => const OrderHistoryPage(),
      ),
      GoRoute(
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
          return OrderDetailsPage(
            orderEntity: orderEntity,
          );
        },
      ),

      // Search
      GoRoute(
        path: RoutersName.search,
        builder: (context, state) => SearchPage(),
      ),
    ],
  );
}
