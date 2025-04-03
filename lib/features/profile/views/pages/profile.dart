import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/constants/app_assets.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/app_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Profile Background
          Container(
            height: 0.25.sh,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AppAssets.profileBackground,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Contents
          Column(
            children: [
              SizedBox(height: 0.185.sh),
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 56,
                      backgroundColor: AppColors.white,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          'https://i.imgur.com/tGbaZCY.jpg',
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Chào bạn',
                      style: AppTypography.black['20_medium'],
                    ),
                    Text(
                      'NGUYỄN HUY PHƯỚC',
                      style: AppTypography.black['24_extraBold'],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // AppBar
          CustomAppBar(
            showLeading: true,
          ),
        ],
      ),
    );
  }
}
