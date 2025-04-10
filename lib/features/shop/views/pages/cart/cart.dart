import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/bloc/cart/cart_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/widgets/cart/checkout_summary.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/widgets/cart/cart_products_card.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/widgets/cart/empty_cart.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/order/cart_item_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/app_bar.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 30.w,
              right: 30.w,
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
              create: (context) => CartBloc()
                ..add(
                  CartDisplayed(),
                ),
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is CartLoaded) {
                    Future.delayed(const Duration(milliseconds: 1500), () {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).clearMaterialBanners();
                      }
                    });

                    return state.products.isEmpty
                        ? const Center(
                            child: EmptyCartPage(),
                          )
                        : Column(
                            children: [
                              Expanded(
                                child: _cartProducts(
                                  state.products,
                                ),
                              ),
                              CheckoutSummary(
                                products: state.products,
                              ),
                            ],
                          );
                  }

                  if (state is CartLoadFailure) {
                    return Center(
                      child: Text(state.message),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cartProducts(List<CartItemModel> products) {
    if (products.isEmpty) {
      return const EmptyCartPage();
    } else {
      return ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        itemBuilder: (context, index) {
          return CartProductsCard(
            item: products[index],
          );
        },
        separatorBuilder: (context, index) => Divider(
          color: AppColors.gray,
          thickness: 1,
          height: 25.h,
          indent: 20.w,
          endIndent: 20.w,
        ),
        itemCount: products.length,
      );
    }
  }
}
