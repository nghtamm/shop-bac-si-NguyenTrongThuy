import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/constants/app_assets.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';

class SearchNotFound extends StatelessWidget {
  const SearchNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.grayLight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppAssets.search,
            height: 120.h,
            width: 120.w,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Sản phẩm bạn tìm kiếm hiện không tồn tại!",
              textAlign: TextAlign.center,
              style: AppTypography.black['24_semiBold'],
            ),
          )
        ],
      ),
    );
  }
}
