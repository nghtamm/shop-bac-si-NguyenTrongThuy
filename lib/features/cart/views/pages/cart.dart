import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/cart/views/bloc/cart_products_display_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/cart/views/bloc/cart_products_display_state.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/cart/views/widgets/cart_appbar.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/cart/views/widgets/product_checkout.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/cart/views/widgets/product_ordered_card.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/entities/product_ordered.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CartAppbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 40, top: 30, bottom: 20),
            child: Text(
              'GIỎ HÀNG',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: BlocProvider(
              create: (context) =>
                  CartProductsDisplayCubit()..displayCartProducts(),
              child: BlocBuilder<CartProductsDisplayCubit,
                  CartProductsDisplayState>(
                builder: (context, state) {
                  if (state is CartProductsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is CartProductsLoaded) {
                    return state.products.isEmpty
                        ? const Center(child: CartEmpty())
                        : Column(
                            children: [
                              Expanded(
                                child: _products(state.products),
                              ),
                              Checkout(
                                products: state.products,
                              ),
                            ],
                          );
                  }
                  if (state is LoadCartProductsFailure) {
                    return Center(
                      child: Text(state.errorMessage),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _products(List<ProductOrderedEntity> products) {
    if (products.isEmpty) {
      return const CartEmpty();
    } else {
      return ListView.separated(
        padding: const EdgeInsets.all(20),
        itemBuilder: (context, index) {
          return ProductOrderedCard(
            productOrderedEntity: products[index],
          );
        },
        separatorBuilder: (context, index) => const Divider(
          color: Colors.grey,
          thickness: 1,
          height: 24,
          indent: 20,
          endIndent: 12,
        ),
        itemCount: products.length,
      );
    }
  }
}

class CartEmpty extends StatelessWidget {
  const CartEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 40,
        left: 40,
        right: 40,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/empty_cart.png',
              width: 200,
              height: 200,
            ),
            const Text(
              'Bạn ơi, chưa có sản phẩm nào được thêm vào giỏ hàng cả!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
