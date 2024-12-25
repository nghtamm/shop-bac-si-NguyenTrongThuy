import 'package:flutter/material.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';

class ProductTitle extends StatelessWidget {
  final ProductEntity productEntity;

  const ProductTitle({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        productEntity.title,
        style: const TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
