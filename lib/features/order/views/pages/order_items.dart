import 'package:flutter/material.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/entities/product_ordered.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/views/pages/product_ordered_card.dart';

class OrderItemsPage extends StatelessWidget {
  final List<ProductOrderedEntity> products;
  const OrderItemsPage({required this.products, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0F1F2),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFF0F1F2),
        child: _products(),
      ),
    );
  }

  Widget _products() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return OrderItemCard(
          productOrderedEntity: products[index],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemCount: products.length,
    );
  }
}
