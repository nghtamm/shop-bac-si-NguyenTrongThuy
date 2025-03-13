import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
<<<<<<< HEAD
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/bloc/product_display_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/bloc/product_display_state.dart';
=======
import 'package:shop_bacsi_nguyentrongthuy/features/search/views/widgets/search_field.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/search/views/widgets/search_not_found.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/bloc/products_bloc.dart';
>>>>>>> nghtamm2003/refactor
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
<<<<<<< HEAD
                if (state is ProductLoading) {
=======
                if (state is ProductsLoading) {
>>>>>>> nghtamm2003/refactor
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

  Widget _searchProducts(List<ProductEntity> products) {
    return Container(
      color: AppColors.grayLight,
<<<<<<< HEAD
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/search.png',
            height: 120.h,
            width: 120.w,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Sản phẩm bạn tìm kiếm hiện không tồn tại!",
              textAlign: TextAlign.center,
              style: AppTypography.black['24_semiBold'],
            ),
          )
        ],
      ),
    );
  }

  Widget _products(List<ProductEntity> products) {
    return Container(
      color: AppColors.grayLight,
=======
>>>>>>> nghtamm2003/refactor
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
            productEntity: products[index],
          );
        },
      ),
    );
  }
}
<<<<<<< HEAD

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      onChanged: (searchValue) {
        if (searchValue.isEmpty) {
          context.read<ProductDisplayCubit>().displayInitial();
        } else {
          context
              .read<ProductDisplayCubit>()
              .displayProducts(params: searchValue);
        }
      },
      decoration: InputDecoration(
        hintText: 'Nhập tên sản phẩm',
        suffixIcon: const Icon(Icons.search_rounded),
        contentPadding: EdgeInsets.symmetric(
          vertical: 10.h,
          horizontal: 15.w,
        ),
      ),
    );
  }
}
=======
>>>>>>> nghtamm2003/refactor
