import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/constants/app_assets.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';

class EmptyOrderHistory extends StatelessWidget {
  const EmptyOrderHistory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppAssets.orderHistory,
            height: 120.h,
            width: 120.w,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 16.h,
            ),
            child: Column(
              children: [
                Text(
                  'Bạn ơi, bạn chưa mua sản phẩm nào cả!',
                  textAlign: TextAlign.center,
                  style: AppTypography.black['24_semiBold'],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Hãy bắt đầu mua sắm tại Shop Bác sĩ Nguyễn Trọng Thủy ngay bây giờ!',
                  textAlign: TextAlign.center,
                  style: AppTypography.black['18_medium'],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
