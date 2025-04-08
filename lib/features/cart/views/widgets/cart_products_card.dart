import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/text_helpers.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/cart/views/bloc/cart_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/cart_item_model.dart';

class CartProductsCard extends StatelessWidget {
  final CartItemModel item;

  const CartProductsCard({
    required this.item,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.h,
      padding: EdgeInsets.only(
        right: 20.w,
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
                        fit: BoxFit.contain,
                        image: NetworkImage(
                          item.image,
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
                        item.title,
                        style: AppTypography.black['20_extraBold'],
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        TextHelpers().formatVNCurrency(item.subtotal),
                        style: AppTypography.black['20_semiBold'],
                      ),
                      item.options!.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Liệu trình: ${item.options}',
                                  style: AppTypography.black['16_medium'],
                                ),
                                SizedBox(height: 2.h),
                              ],
                            )
                          : const SizedBox.shrink(),
                      Text(
                        'Số lượng: ${item.quantity}',
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
                      key:
                          '${item.productID.toString()}-${item.optionsID.toString()}',
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
            child: Transform.translate(
              offset: Offset(0, -14.h),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 24.h,
                  width: 24.w,
                  decoration: const BoxDecoration(
                    color: AppColors.redSoft,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.remove,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
