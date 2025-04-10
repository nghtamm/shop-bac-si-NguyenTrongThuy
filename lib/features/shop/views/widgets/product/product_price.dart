import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/text_helpers.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/product/product_model.dart';

class ProductPrice extends StatelessWidget {
  final ProductModel productModel;

  const ProductPrice({
    super.key,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.w,
      ),
      child: Container(
        child: productModel.salePrice != ''
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Giá gốc:',
                        style: AppTypography.black['18_medium'],
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        TextHelpers()
                            .formatVNCurrency(productModel.regularPrice),
                        style: AppTypography.black['18_bold']?.copyWith(
                          decoration: TextDecoration.lineThrough,
                          color: AppColors.black.withOpacity(0.6),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 12.w,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          'Tiết kiệm ${(100 - (double.parse(productModel.salePrice!) / double.parse(productModel.regularPrice!) * 100)).toStringAsFixed(0)}%',
                          style: AppTypography.white['16_medium'],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.h,
                      horizontal: 16.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.grayNeutral,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      TextHelpers().formatVNCurrency(productModel.salePrice),
                      style: AppTypography.black['22_extraBold'],
                    ),
                  ),
                ],
              )
            : Container(
                padding: EdgeInsets.symmetric(
                  vertical: 8.h,
                  horizontal: 16.w,
                ),
                decoration: BoxDecoration(
                  color: AppColors.grayNeutral,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  TextHelpers().formatVNCurrency(productModel.price),
                  style: AppTypography.black['22_extraBold'],
                ),
              ),
      ),
    );
  }
}
