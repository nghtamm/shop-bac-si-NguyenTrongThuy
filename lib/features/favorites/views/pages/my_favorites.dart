import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/bloc/products_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product_entity.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/app_bar.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/product_card.dart';

class MyFavoritesPage extends StatelessWidget {
  const MyFavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsBloc()
        ..add(
          FavoritesDisplayed(),
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
                              'SẢN PHẨM YÊU THÍCH CỦA BẠN',
                              style: AppTypography.black['32_extraBold'],
                            ),
                          ),
                        ),
                      ),
                      // Expanded(
                      //   child: _favorites(
                      //     state.products,
                      //   ),
                      // ),
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

  Widget _favorites(List<ProductEntity> products) {
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
          // return ProductCard(
          //   productEntity: products[index],
          // );
        },
      ),
    );
  }
}
