import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/bloc/products_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/widgets/home_products_card.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';

class DoctorChoice extends StatelessWidget {
  const DoctorChoice({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsBloc()..add(HomeProductsDisplayed()),
      child: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProductsLoaded) {
            return _dcProducts(
              state.products,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _dcProducts(List<ProductEntity> products) {
    return SizedBox(
      height: 300.h,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: 40.w,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return HomeProductsCard(
            productEntity: products[index],
          );
        },
      ),
    );
  }
}
