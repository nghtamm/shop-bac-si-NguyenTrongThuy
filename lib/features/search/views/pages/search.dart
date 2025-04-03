import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/models/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/search/views/widgets/search_field.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/search/views/widgets/search_not_found.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/bloc/products_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/product_card.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductsBloc()..add(SearchProductsDisplayed(query: '')),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.transparent,
              elevation: 0,
              toolbarHeight: 80.h,
              title: SearchField(
                searchController: _searchController,
              ),
            ),
            body: BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
                if (state is ProductsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ProductsLoaded) {
                  return state.products.isEmpty
                      ? const SearchNotFound()
                      : _searchProducts(
                          state.products,
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

  Widget _searchProducts(List<ProductModel> products) {
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
