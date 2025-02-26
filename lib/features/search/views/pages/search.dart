import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/bloc/product_display_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/bloc/product_display_state.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/usecase/get_product_by_title_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/search/views/widgets/product_card.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDisplayCubit(
          useCase: serviceLocator<GetProductByTitleUseCase>()),
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
            body: BlocBuilder<ProductDisplayCubit, ProductDisplayState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ProductLoaded) {
                  return state.products.isEmpty
                      ? _notFound()
                      : _products(state.products);
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

  Widget _notFound() {
    return Container(
      color: AppColors.grayLight,
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
          return ProductCard(productEntity: products[index]);
        },
      ),
    );
  }
}

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
