import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/constants/app_assets.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppAssets.onboardingBackground,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 50.h,
              horizontal: 20.w,
            ),
            child: SizedBox.expand(
              child: Column(
                children: [
                  const Spacer(),
                  Text(
                    'SHOPBACSINGUYENTRONGTHUY',
                    style: AppTypography.black['16_medium'],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'BẢO VỆ SỨC KHỎE,\n NGAY BÂY GIỜ!',
                    style: AppTypography.black['32_extraBold'],
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        context.go(RoutersName.authentication);
                      },
                      child: Text(
                        'BẮT ĐẦU',
                        style: AppTypography.white['24_extraBold'],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
