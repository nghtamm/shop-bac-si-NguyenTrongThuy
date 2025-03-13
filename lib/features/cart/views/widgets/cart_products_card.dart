import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/cart/views/bloc/cart_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/entities/product_ordered.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/image_helpers.dart';

class CartProductsCard extends StatelessWidget {
  final ProductOrderedEntity productOrderedEntity;

  const CartProductsCard({
    required this.productOrderedEntity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
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
                        style: AppTypography.black['20_extraBold'],
                      ),
                      Text(
                        '${productOrderedEntity.totalPrice}đ',
                        style: AppTypography.black['20_semiBold'],
                      ),
                      Text(
                        'Số lượng: ${productOrderedEntity.productQuantity}',
                        style: AppTypography.black['16_medium'],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              context.read<CartBloc>().add(
                    CartProductRemoved(
                      productID: productOrderedEntity.id,
                    ),
                  );

              ScaffoldMessenger.of(context).showMaterialBanner(
                const MaterialBanner(
                  forceActionsBelow: true,
                  content: AwesomeSnackbarContent(
                    title: 'Cập nhật giỏ hàng',
                    message: 'Đã xóa thành công sản phẩm khỏi giỏ hàng!',
                    contentType: ContentType.success,
                    inMaterialBanner: true,
                  ),
                  actions: [
                    SizedBox.shrink(),
                  ],
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 23.h,
                  width: 23.w,
                  decoration: const BoxDecoration(
                    color: AppColors.redSoft,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.remove,
                    size: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
