import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/order/order_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/views/widgets/order/history_product_card.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/app_bar.dart';

class OrderItemsPage extends StatelessWidget {
  final OrderModel products;

  const OrderItemsPage({
    required this.products,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        backgroundColor: AppColors.grayLight,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.grayLight,
        child: _orderedProducts(),
      ),
    );
  }

  Widget _orderedProducts() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return HistoryProductCard(
          product: products.lineItems[index],
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 10.h,
      ),
      itemCount: products.lineItems.length,
    );
  }
}
