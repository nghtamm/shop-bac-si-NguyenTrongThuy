import 'package:flutter/material.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/widgets/product_appbar.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/widgets/product_image.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/widgets/product_price.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/widgets/product_title.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/views/widgets/product_desc.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductDetailPage({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ProductAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductImages(productEntity: productEntity),
              const SizedBox(height: 60),
              ProductTitle(productEntity: productEntity),
              const SizedBox(height: 10),
              ProductPrice(productEntity: productEntity),
              const SizedBox(height: 20),
              ProductDesc(productEntity: productEntity),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
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
      ),
    );
  }
}
