import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/constants/app_assets.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';

class ChatbotAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatbotAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      toolbarHeight: 80.h,
      leading: Transform.translate(
        offset: Offset(8.w, 12.h),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 24,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      title: Transform.translate(
        offset: Offset(0.w, 12.h),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 22,
              backgroundImage: AssetImage(AppAssets.capybara),
            ),
            SizedBox(width: 14.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bác sĩ Capybara',
                  style: AppTypography.black['18_bold'],
                ),
                Text(
                  'Tư vấn sức khỏe cơ - xương - khớp',
                  style: AppTypography.black['12_regular']?.copyWith(
                    color: AppColors.gray,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80.h);
}
