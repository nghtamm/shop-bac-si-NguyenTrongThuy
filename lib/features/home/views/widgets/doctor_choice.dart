import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/appnavigator.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/image_display.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/bloc/product_display_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/bloc/product_display_state.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/widgets/product_card.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product_detail/views/pages/product_detail.dart';

class DoctorChoice extends StatelessWidget {
  const DoctorChoice({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDisplayCubit()..displayProducts(),
      child: BlocBuilder<ProductDisplayCubit, ProductDisplayState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProductLoaded) {
            return _products(state.products);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _products(List<ProductEntity> products) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(productEntity: products[index]);
        },
      ),
    );
  }
}
