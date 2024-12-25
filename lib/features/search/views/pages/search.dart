import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/bloc/product_display_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/bloc/product_display_state.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/usecase/get_product_by_title_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/search/views/widgets/product_card.dart';
import 'package:shop_bacsi_nguyentrongthuy/service_locator.dart';

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
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 80,
              title: SearchField(searchController: _searchController),
            ),
            body: BlocBuilder<ProductDisplayCubit, ProductDisplayState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ProductLoaded) {
                  return state.products.isEmpty
                      ? _notFound()
                      : _products(state.products);
                }
                return Container(
                  color: const Color(0xFFF0F1F2),
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
      color: const Color(0xFFF0F1F2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/search.png',
            height: 120,
            width: 120,
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Sản phẩm bạn tìm kiếm hiện không tồn tại!",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
            ),
          )
        ],
      ),
    );
  }

  Widget _products(List<ProductEntity> products) {
    return Container(
      color: const Color(0xFFF0F1F2),
      child: GridView.builder(
        itemCount: products.length,
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
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
      decoration: const InputDecoration(
        hintText: 'Nhập tên sản phẩm',
        suffixIcon: Icon(Icons.search_rounded),
        contentPadding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
      ),
    );
  }
}
