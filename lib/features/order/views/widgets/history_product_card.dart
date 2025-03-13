import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
<<<<<<< HEAD:lib/features/order/views/pages/product_ordered_card.dart
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/image_display.dart';
=======
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/image_helpers.dart';
>>>>>>> nghtamm2003/refactor:lib/features/order/views/widgets/history_product_card.dart
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/entities/product_ordered.dart';

class HistoryProductCard extends StatelessWidget {
  final ProductOrderedEntity productOrderedEntity;

<<<<<<< HEAD:lib/features/order/views/pages/product_ordered_card.dart
  const OrderItemCard({required this.productOrderedEntity, super.key});
=======
  const HistoryProductCard({
    required this.productOrderedEntity,
    super.key,
  });
>>>>>>> nghtamm2003/refactor:lib/features/order/views/widgets/history_product_card.dart

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.gray,
          width: 0.5.w,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    width: 90.w,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          ImageHelpers.generateProductImageURL(
                            productOrderedEntity.productImage,
                          ),
                        ),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productOrderedEntity.productTitle,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.black['20_semiBold'],
                      ),
                      Text(
                        '${productOrderedEntity.totalPrice}đ',
                        style: AppTypography.black['18_medium'],
                      ),
                      Text(
                        'Số lượng: ${productOrderedEntity.productQuantity}',
                        style: AppTypography.black['16_regular'],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
