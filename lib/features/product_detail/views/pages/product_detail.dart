import 'package:flutter/material.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product_detail/views/widgets/product_appbar.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ProductAppbar(),
      body: Center(
        child: Text('Product Detail Page'),
      ),
    );
  }
}
