import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/domain/entities/product.dart';

class ProductPrice extends StatelessWidget {
  final ProductEntity productEntity;

<<<<<<< HEAD
  const ProductPrice({super.key, required this.productEntity});
=======
  const ProductPrice({
    super.key,
    required this.productEntity,
  });
>>>>>>> nghtamm2003/refactor

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.w,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 8.h,
          horizontal: 16.w,
        ),
        decoration: BoxDecoration(
          color: AppColors.grayNeutral,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          '${productEntity.price}đ',
          style: AppTypography.black['22_extraBold'],
        ),
      ),
    );
  }
}
