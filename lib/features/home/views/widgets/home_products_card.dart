import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/text_helpers.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/product/data/models/product_model.dart';

class HomeProductsCard extends StatelessWidget {
  final ProductModel productModel;

  const HomeProductsCard({
    super.key,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          RoutersName.productDetails,
          extra: productModel,
        );
      },
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 50.h,
                ),
                child: SizedBox(
                  height: 220.h,
                  width: 300.w,
                  child: ElevatedButton(
                    onPressed: () {
                      context.push(
                        RoutersName.productDetails,
                        extra: productModel,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blueLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.h,
                        horizontal: 0.w,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 80.h),
                          Text(
                            productModel.title,
                            style: AppTypography.black['18_semiBold'],
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            TextHelpers()
                                .formatHTML(productModel.shortDescription),
                            style: AppTypography.black['12_medium'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            TextHelpers().formatVNCurrency(productModel.price),
                            style: AppTypography.black['28_extraBold'],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20.w,
                  ),
                  child: Image.network(
                    productModel.images[0],
                    height: 150.h,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 20.w),
        ],
      ),
    );
  }
}
