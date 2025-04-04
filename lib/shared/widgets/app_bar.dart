import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Color backgroundColor;
  final bool showLeading;
  final List<Widget>? actions;
  final double height;

  const CustomAppBar({
    super.key,
    this.title,
    this.showLeading = true,
    this.actions,
    this.backgroundColor = AppColors.transparent,
    this.height = kToolbarHeight,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      centerTitle: true,
      backgroundColor: backgroundColor,
      elevation: 0,
      leading: showLeading
          ? Transform.translate(
              offset: Offset(8.w, 12.h),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 24,
                ),
                onPressed: () => context.pop(),
              ),
            )
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
