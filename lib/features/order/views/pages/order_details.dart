import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/data/models/order_model.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/app_bar.dart';

class OrderDetailsPage extends StatelessWidget {
  final OrderModel orderModel;

  const OrderDetailsPage({
    required this.orderModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        backgroundColor: AppColors.grayLight,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.grayLight,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _items(context),
              SizedBox(height: 30.h),
              _shipping(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _items(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DANH SÁCH SẢN PHẨM ĐÃ MUA',
          style: AppTypography.black['32_bold'],
        ),
        SizedBox(height: 20.h),
        GestureDetector(
          onTap: () {
            context.push(
              RoutersName.orderItems,
              extra: orderModel,
            );
          },
          child: Container(
            height: 80.h,
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.receipt_rounded,
                      size: 30,
                    ),
                    SizedBox(width: 20.w),
                    Text(
                      '${orderModel.lineItems.length} sản phẩm',
                      style: AppTypography.black['16_semiBold'],
                    )
                  ],
                ),
                Text(
                  'Xem chi tiết',
                  style: AppTypography.black['14_regular'],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _shipping() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'THÔNG TIN GIAO NHẬN HÀNG',
          style: AppTypography.black['32_bold'],
        ),
        SizedBox(height: 10.h),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Người nhận',
            style: AppTypography.black['18_semiBold'],
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            '${orderModel.billing.firstName} ${orderModel.billing.lastName}',
            style: AppTypography.black['18_medium'],
          ),
        ),
        SizedBox(height: 20.h),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Số điện thoại',
            style: AppTypography.black['18_semiBold'],
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            orderModel.billing.phone,
            style: AppTypography.black['18_medium'],
          ),
        ),
        SizedBox(height: 20.h),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Địa chỉ',
            style: AppTypography.black['18_semiBold'],
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            '${orderModel.shipping.address1}, ${orderModel.shipping.address2}, ${orderModel.shipping.city}, ${orderModel.shipping.state}, ${orderModel.shipping.country}',
            style: AppTypography.black['18_medium'],
          ),
        ),
      ],
    );
  }
}
