import 'package:flutter/material.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';

class ProductDesc extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductDesc({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Text(
        productEntity.description,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
