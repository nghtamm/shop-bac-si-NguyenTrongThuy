import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/entities/product_ordered.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/views/widgets/history_product_card.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/app_bar.dart';

class OrderItemsPage extends StatelessWidget {
  final List<ProductOrderedEntity> products;

  const OrderItemsPage({required this.products, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      appBar: AppBar(
        backgroundColor: AppColors.grayLight,
        elevation: 0,
=======
      appBar: const CustomAppBar(
        backgroundColor: AppColors.grayLight,
>>>>>>> nghtamm2003/refactor
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.grayLight,
<<<<<<< HEAD
        child: _products(),
=======
        child: _orderedProducts(),
>>>>>>> nghtamm2003/refactor
      ),
    );
  }

  Widget _orderedProducts() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return HistoryProductCard(
          productOrderedEntity: products[index],
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 10.h,
      ),
      itemCount: products.length,
    );
  }
}
