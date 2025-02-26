import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/get_display_name_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/google_sign_in_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20.h,
          horizontal: 40.w,
        ),
        child: Column(
          children: [
            const Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'XIN CHÀO!',
                style: AppTypography.black['32_extraBold'],
              ),
            ),
            SizedBox(height: 5.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Lựa chọn đăng ký hoặc đăng nhập để tiếp tục',
                style: AppTypography.black['18_medium'],
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                context.push(RoutersName.signUp);
              },
              child: Text(
                'ĐĂNG KÝ',
                style: AppTypography.white['24_extraBold'],
              ),
            ),
            SizedBox(height: 10.h),
            ElevatedButton(
              onPressed: () {
                context.push(RoutersName.signIn);
              },
              child: Text(
                'ĐĂNG NHẬP',
                style: AppTypography.white['24_extraBold'],
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'hoặc đăng nhập với',
              style: AppTypography.black['16_medium'],
            ),
            SizedBox(height: 15.h),
            _AuthenticationSocialButtons(),
            const Spacer(),
            TextButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (BuildContext context) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.w,
                        vertical: 30.h,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ĐIỀU KHOẢN VÀ THỎA THUẬN NGƯỜI DÙNG',
                            style: AppTypography.black['20_bold'],
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            'Chỗ này bao gồm nội dung của điều khoản và thỏa thuận người dùng. Người dùng cần đọc kỹ trước khi sử dụng ứng dụng.',
                            style: AppTypography.black['16_regular'],
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 20.h),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () {
                                context.pop();
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(100.w, 50.h),
                              ),
                              child: Text(
                                'TÔI ĐÃ HIỂU',
                                style: AppTypography.white['18_extraBold'],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Text(
                'Thỏa thuận người dùng (EULA)',
                style: AppTypography.black['18_medium'],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthenticationSocialButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () async {
            var result = await serviceLocator<GoogleSignInUseCase>().call();
            result.fold(
              (left) {
                var snackBar = SnackBar(
                  content: Text(left),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              (right) async {
                var displayName =
                    await serviceLocator<GetDisplayNameUseCase>().call();

                if (context.mounted) {
                  context.go(
                    RoutersName.homepage,
                    extra: displayName,
                  );
                }
              },
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.blueGray,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            minimumSize: Size(90.w, 50.h),
          ),
          child: Image.asset(
            'assets/images/google_icon.png',
            height: 30.h,
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.blueGray,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            minimumSize: Size(90.w, 50.h),
          ),
          child: Image.asset(
            'assets/images/apple_icon.png',
            height: 30,
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.blueGray,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            minimumSize: Size(90.w, 50.h),
          ),
          child: Image.asset(
            'assets/images/facebook_icon.png',
            height: 30.h,
          ),
        ),
      ],
    );
  }
}
