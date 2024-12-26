import 'package:flutter/material.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/app_navigator.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/cart_helper.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/checkout/views/pages/checkout.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/entities/product_ordered.dart';

class Checkout extends StatelessWidget {
  final List<ProductOrderedEntity> products;
  const Checkout({required this.products, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 40, right: 40, bottom: 40, top: 20),
      height: MediaQuery.of(context).size.height / 3.5,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tiền sản phẩm',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '${CartHelper.calculateCartSubtotal(products).toString()}đ',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Phí vận chuyển',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '25000đ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tổng tiền',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '${CartHelper.calculateCartSubtotal(products) + 25000}đ',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              child: const Text(
                'THÊM VÀO GIỎ HÀNG',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                AppNavigator.push(
                  context,
                  CheckoutPage(
                    products: products,
                  ),
                );
              })
        ],
      ),
    );
  }
}
