import 'package:flutter/material.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/app_navigator.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/entities/order.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/views/pages/order_items.dart';

class OrderDetailPage extends StatelessWidget {
  final OrderEntity orderEntity;
  const OrderDetailPage({required this.orderEntity, super.key});

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _items(context),
              const SizedBox(height: 30),
              _shipping()
            ],
          ),
        ),
      ),
    );
  }

  Widget _items(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'DANH SÁCH SẢN PHẨM ĐÃ MUA',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            AppNavigator.push(
              context,
              OrderItemsPage(products: orderEntity.products),
            );
          },
          child: Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.receipt_rounded,
                      size: 30,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      '${orderEntity.products.length} sản phẩm',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
                const Text(
                  'Xem chi tiết',
                  style: TextStyle(fontSize: 14),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _shipping() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'THÔNG TIN GIAO NHẬN HÀNG',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
        const SizedBox(height: 10),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Người nhận',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            orderEntity.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Số điện thoại',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            orderEntity.phoneNumber,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Địa chỉ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            orderEntity.shippingAddress,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
