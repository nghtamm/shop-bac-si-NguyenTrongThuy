import 'package:flutter/material.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product_detail/views/widgets/product_appbar.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product_detail/views/widgets/product_image.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product_detail/views/widgets/product_price.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product_detail/views/widgets/product_title.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product_detail/views/widgets/product_desc.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductDetailPage({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F1F2),
      appBar: const ProductAppbar(),
      body: Stack(
        children: [
          // Phần chia background màu
          Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: const Color(0xFFF0F1F2), // Màu nền phần trên
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  color: Colors.white, // Màu nền phần dưới
                ),
              ),
            ],
          ),
          // Nội dung chính
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductImages(productEntity: productEntity),
                const SizedBox(height: 74),
                ProductTitle(productEntity: productEntity),
                const SizedBox(height: 6),
                ProductPrice(productEntity: productEntity),
                const SizedBox(height: 16),
                ProductDesc(productEntity: productEntity),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'THÊM VÀO GIỎ HÀNG',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
