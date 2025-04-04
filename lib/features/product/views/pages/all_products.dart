import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/models/product_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/bloc/products_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/app_bar.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/product_card.dart';

class AllProductPage extends StatelessWidget {
  const AllProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => ProductsBloc()
        ..add(
          AllProductsDisplayed(),
        ),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: const CustomAppBar(
              backgroundColor: AppColors.grayLight,
            ),
            body: BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
                if (state is ProductsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ProductsLoaded) {
                  return Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: AppColors.grayLight,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 25.w,
                            vertical: 5.h,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'TẤT CẢ SẢN PHẨM',
                              style: AppTypography.black['32_extraBold'],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: _products(
                          state.products,
                        ),
                      ),
                    ],
                  );
                }
                return Container(
                  color: AppColors.grayLight,
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _products(List<ProductModel> products) {
    return Container(
      color: AppColors.grayLight,
      child: GridView.builder(
        itemCount: products.length,
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
          childAspectRatio: 0.6,
        ),
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(
            productModel: products[index],
          );
        },
      ),
    );
  }
}
