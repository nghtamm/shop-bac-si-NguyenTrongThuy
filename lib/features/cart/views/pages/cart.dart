import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
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
      backgroundColor: AppColors.white,
      appBar: const CartAppbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 40.w,
              top: 30.h,
              bottom: 20.h,
            ),
            child: Text(
              'GIỎ HÀNG',
              style: AppTypography.black['32_extraBold'],
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
        separatorBuilder: (context, index) => Divider(
          color: AppColors.gray,
          thickness: 1,
          height: 24.h,
          indent: 20.w,
          endIndent: 12.w,
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
      padding: EdgeInsets.only(
        bottom: 40.h,
        left: 40.w,
        right: 40.w,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/empty_cart.png',
              width: 200.w,
              height: 200.h,
            ),
            Text(
              'Bạn ơi, chưa có sản phẩm nào được thêm vào giỏ hàng cả!',
              style: AppTypography.black['24_semiBold'],
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
