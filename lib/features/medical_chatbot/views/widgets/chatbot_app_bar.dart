import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/constants/app_assets.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';

class ChatbotAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ChatbotAppbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.black,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        title: Row(
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
                  'Tư vấn sức khoẻ',
                  style: AppTypography.black['18_bold'],
                ),
                Text(
                  'Chuột lang nước',
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
}
