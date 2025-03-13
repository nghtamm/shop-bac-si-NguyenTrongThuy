import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/constants/app_assets.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';

class EmptyCartPage extends StatelessWidget {
  const EmptyCartPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 40.h,
        left: 40.w,
        right: 40.w,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppAssets.emptyCart,
              width: 200.w,
              height: 200.h,
            ),
            Text(
              'Bạn ơi, chưa có sản phẩm nào được thêm vào giỏ hàng cả!',
              style: AppTypography.black['24_semiBold'],
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
