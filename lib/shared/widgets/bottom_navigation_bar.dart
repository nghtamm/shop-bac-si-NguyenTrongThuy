import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';

class CustomBottomNavbar extends StatelessWidget {
  final VoidCallback? onTap;

  const CustomBottomNavbar({
    super.key,
    this.onTap,
  });

  void _onTabTap(BuildContext context, int index) {
    if (index == 0) {
      if (onTap != null) {
        onTap!();
      }
    } else if (index == 1) {
      context.push(RoutersName.cart);
    } else if (index == 2) {
      context.push(RoutersName.orderHistory);
    } else if (index == 3) {
      context.push(RoutersName.profile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.h,
      margin: EdgeInsets.only(
        bottom: 20.h,
        left: 30.w,
        right: 30.w,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavbarTab(
            context,
            Icons.home_outlined,
            0,
          ),
          _buildNavbarTab(
            context,
            Icons.shopping_cart_outlined,
            1,
          ),
          _buildNavbarTab(
            context,
            Icons.local_mall_outlined,
            2,
          ),
          _buildNavbarTab(
            context,
            Icons.menu_rounded,
            3,
          ),
        ],
      ),
    );
  }

  Widget _buildNavbarTab(BuildContext context, IconData icon, int index) {
    final bool isHomepage;

    if (index == 0) {
      isHomepage = true;
    } else {
      isHomepage = false;
    }

    return GestureDetector(
      onTap: () => _onTabTap(context, index),
      child: Icon(
        icon,
        size: 32,
        color: isHomepage ? AppColors.white : AppColors.white.withOpacity(0.6),
      ),
    );
  }
}
