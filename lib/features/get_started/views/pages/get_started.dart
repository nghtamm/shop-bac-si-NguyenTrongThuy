import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
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
              'assets/images/get_started_background.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 50.h,
              horizontal: 50.w,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  'SHOPBACSINGUYENTRONGTHUY',
                  style: AppTypography.black['14_medium'],
                ),
                SizedBox(height: 8.h),
                Text(
                  'BẢO VỆ SỨC KHỎE,\n NGAY BÂY GIỜ!',
                  style: AppTypography.black['28_extraBold'],
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30.h),
                ElevatedButton(
                  onPressed: () {
                    context.go(RoutersName.authentication);
                  },
                  child: Text(
                    'BẮT ĐẦU',
                    style: AppTypography.white['24_extraBold'],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
