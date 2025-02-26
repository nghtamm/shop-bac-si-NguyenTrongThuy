import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/order/domain/entities/order.dart';

class OrderDetailPage extends StatelessWidget {
  final OrderEntity orderEntity;

  const OrderDetailPage({required this.orderEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.grayLight,
        elevation: 0,
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
              extra: orderEntity.products,
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
                      '${orderEntity.products.length} sản phẩm',
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
            orderEntity.name,
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
            orderEntity.phoneNumber,
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
            orderEntity.shippingAddress,
            style: AppTypography.black['18_medium'],
          ),
        ),
      ],
    );
  }
}
