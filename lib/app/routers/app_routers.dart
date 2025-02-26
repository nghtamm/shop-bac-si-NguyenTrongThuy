import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/pages/authentication.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/pages/forgot_password.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/pages/sign_in.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/pages/sign_up.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/cart/views/pages/cart.dart';
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
import 'package:shop_bacsi_nguyentrongthuy/features/search/views/pages/search.dart';

class AppRouters {
  static final GoRouter router = GoRouter(
    initialLocation: RoutersName.root,
    routes: [
      GoRoute(
        path: RoutersName.root,
        builder: (context, state) {
          final authState = context.read<AuthenticationCubit>().state;

          if (authState is Authenticated) {
            return HomePage(displayName: authState.displayName);
          } else {
            return const GetStartedPage();
          }
        },
      ),
      GoRoute(
        path: RoutersName.getStarted,
        builder: (context, state) => const GetStartedPage(),
      ),
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
      GoRoute(
        path: RoutersName.homepage,
        builder: (context, state) {
          final displayName = state.extra as String;
          return HomePage(
            displayName: displayName,
          );
        },
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
      GoRoute(
        path: RoutersName.myFavorites,
        builder: (context, state) => const MyFavoritesPage(),
      ),
      GoRoute(
        path: RoutersName.cart,
        builder: (context, state) => const CartPage(),
      ),
      GoRoute(
        path: RoutersName.orderHistory,
        builder: (context, state) => const OrderHistoryPage(),
      ),
      GoRoute(
        path: RoutersName.aiChat,
        builder: (context, state) => const AiChat(),
      ),
      GoRoute(
        path: RoutersName.search,
        builder: (context, state) => SearchPage(),
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
          return OrderDetailPage(
            orderEntity: orderEntity,
          );
        },
      ),
    ],
  );
}
