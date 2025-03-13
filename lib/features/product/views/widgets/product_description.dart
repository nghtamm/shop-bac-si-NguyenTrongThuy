import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';

class ProductDescription extends StatelessWidget {
  final ProductEntity productEntity;

  const ProductDescription({
    super.key,
    required this.productEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.w,
      ),
      child: Text(
        productEntity.description,
        style: AppTypography.black['16_medium'],
        textAlign: TextAlign.justify,
      ),
    );
  }
}
