import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/pages/authentication.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/pages/forgot_password.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/pages/google_sign_in.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/pages/sign_in.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/pages/sign_up.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/pages/cart/cart.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/pages/cart/checkout_payment.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/pages/favorites/my_favorites.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/medical_chatbot/views/pages/chatbot.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/pages/cart/checkout.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/onboarding/views/pages/onboarding.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/pages/home.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/order/cart_item_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/order/order_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/pages/order/order_details.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/pages/order/order_history.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/pages/cart/order_placed.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/product/product_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/pages/product/all_products.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/pages/product/product_details.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/profile/views/pages/profile.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/pages/search/search.dart';

final RouteObserver<ModalRoute<void>> observer =
    RouteObserver<ModalRoute<void>>();

class AppRouters {
  static final GoRouter router = GoRouter(
    initialLocation: RoutersName.root,
    observers: [observer],
    routes: [
      // ROOT
      GoRoute(
        path: RoutersName.root,
        builder: (context, state) => const OnboardingPage(),
      ),

      // MODULES
      // Onboarding
      GoRoute(
        path: RoutersName.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),

      // Authentication
      GoRoute(
        path: RoutersName.authentication,
        builder: (context, state) => const AuthenticationPage(),
      ),
      GoRoute(
        path: RoutersName.signUp,
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: RoutersName.signIn,
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: RoutersName.forgotPassword,
        builder: (context, state) => ForgotPasswordPage(),
      ),
      GoRoute(
        path: RoutersName.googleLogin,
        builder: (context, state) {
          final userData = state.extra as Map<String, dynamic>;
          return GoogleSignInPage(
            userData: userData,
          );
        },
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
          final data = state.extra as Map<String, dynamic>;
          final products = data['products'] as List<CartItemModel>;
          final shipping = data['shipping'] as num;

          return CheckoutPage(
            products: products,
            shipping: shipping,
          );
        },
      ),
      GoRoute(
        path: RoutersName.orderPlaced,
        builder: (context, state) => const OrderPlacedPage(),
      ),
      GoRoute(
        path: RoutersName.checkoutPayment,
        builder: (context, state) {
          final url = state.extra as String;
          return CheckoutPaymentPage(
            url: url,
          );
        },
      ),

      // Favorites
      GoRoute(
        path: RoutersName.myFavorites,
        builder: (context, state) => const MyFavoritesPage(),
      ),

      // Medical Chatbot
      GoRoute(
        path: RoutersName.chatbot,
        builder: (context, state) => const ChatbotPage(),
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
        path: RoutersName.orderDetails,
        builder: (context, state) {
          final orderModel = state.extra as OrderModel;
          return OrderDetailsPage(
            orderModel: orderModel,
          );
        },
      ),

      // Search
      GoRoute(
        path: RoutersName.search,
        builder: (context, state) => const SearchPage(),
      ),

      // Profile
      GoRoute(
        path: RoutersName.profile,
        builder: (context, state) => const ProfilePage(),
      ),
    ],
  );
}
