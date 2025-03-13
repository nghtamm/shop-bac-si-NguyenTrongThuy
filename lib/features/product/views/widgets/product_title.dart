import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';

class ProductTitle extends StatelessWidget {
  final ProductEntity productEntity;

  const ProductTitle({
    required this.productEntity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.w,
      ),
      child: Text(
        productEntity.title,
        style: AppTypography.black['26_extraBold'],
      ),
    );
  }
}
