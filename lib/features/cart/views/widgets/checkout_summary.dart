import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/cart_helpers.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/text_helpers.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/cart_item_model.dart';

class CheckoutSummary extends StatelessWidget {
  final List<CartItemModel> products;

  const CheckoutSummary({
    required this.products,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final num subtotal = CartHelpers.calculateSubtotal(products);
    final num shipping = subtotal >= 1000000 ? 0 : 25000;
    final num total = subtotal + shipping;

    return Container(
      padding: EdgeInsets.only(
        left: 40.w,
        right: 40.w,
        bottom: 40.h,
        top: 20.h,
      ),
      height: 1.sh / 3.5,
      color: AppColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tiền sản phẩm',
                style: AppTypography.black['16_semiBold'],
              ),
              Text(
                TextHelpers().formatVNCurrency(subtotal.toString()),
                style: AppTypography.black['16_bold'],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Phí vận chuyển',
                style: AppTypography.black['16_semiBold'],
              ),
              Text(
                TextHelpers().formatVNCurrency(shipping.toString()),
                style: AppTypography.black['16_bold'],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng tiền',
                style: AppTypography.black['16_semiBold'],
              ),
              Text(
                TextHelpers().formatVNCurrency(total.toString()),
                style: AppTypography.black['16_bold'],
              )
            ],
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
            child: Text(
              'THÊM VÀO GIỎ HÀNG',
              style: AppTypography.white['22_extraBold'],
            ),
            onPressed: () {
              context.push(
                RoutersName.checkout,
                extra: {
                  'products': products,
                  'shipping': shipping,
                },
              );
            },
          )
        ],
      ),
    );
  }
}
