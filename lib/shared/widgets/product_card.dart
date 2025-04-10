import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/text_helpers.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/models/product/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel productModel;

  const ProductCard({
    required this.productModel,
    super.key,
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
      child: Container(
        width: 180.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  color: AppColors.white,
                  child: CachedNetworkImage(
                    imageUrl: productModel.images[0],
                    fit: BoxFit.contain,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  border: Border(
                    top: BorderSide(
                      color: AppColors.gray,
                      width: 0.1.w,
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: 14.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productModel.title,
                        style: AppTypography.black['14_medium']?.copyWith(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      productModel.salePrice != ''
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      TextHelpers().formatVNCurrency(
                                        productModel.regularPrice,
                                      ),
                                      style: AppTypography.black['16_semiBold']
                                          ?.copyWith(
                                        decoration: TextDecoration.lineThrough,
                                        color: AppColors.black.withOpacity(0.6),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: 8.w,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 4.w,
                                        vertical: 2.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                      ),
                                      child: Text(
                                        '-${(100 - (double.parse(productModel.salePrice!) / double.parse(productModel.regularPrice!) * 100)).toStringAsFixed(0)}%',
                                        style:
                                            AppTypography.white['12_regular'],
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  TextHelpers()
                                      .formatVNCurrency(productModel.salePrice),
                                  style: AppTypography.black['22_bold'],
                                ),
                              ],
                            )
                          : Text(
                              TextHelpers()
                                  .formatVNCurrency(productModel.price),
                              style: AppTypography.black['22_bold'],
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
