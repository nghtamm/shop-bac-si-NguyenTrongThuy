import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/constants/privacy_policy.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/widgets/google_login_button.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20.h,
            horizontal: 20.w,
          ),
          child: Column(
            children: [
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'XIN CHÀO!',
                    style: AppTypography.black['32_extraBold'],
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Lựa chọn đăng ký hoặc đăng nhập để tiếp tục',
                    style: AppTypography.black['18_medium'],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    context.push(RoutersName.signUp);
                  },
                  child: Text(
                    'ĐĂNG KÝ',
                    style: AppTypography.white['24_extraBold'],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    context.push(RoutersName.signIn);
                  },
                  child: Text(
                    'ĐĂNG NHẬP',
                    style: AppTypography.white['24_extraBold'],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'hoặc đăng nhập với',
                style: AppTypography.black['16_medium'],
              ),
              SizedBox(height: 15.h),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: const GoogleLoginButton(),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return DraggableScrollableSheet(
                        expand: false,
                        initialChildSize: 0.75,
                        minChildSize: 0.5,
                        maxChildSize: 0.9,
                        builder: (context, scrollController) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 40.w,
                              vertical: 30.h,
                            ),
                            child: SingleChildScrollView(
                              controller: scrollController,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ĐIỀU KHOẢN VÀ THỎA THUẬN NGƯỜI DÙNG',
                                    style: AppTypography.black['20_bold'],
                                  ),
                                  SizedBox(height: 15.h),
                                  Text(
                                    PrivacyPolicy.content,
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
                                        style:
                                            AppTypography.white['18_extraBold'],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
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
      ),
    );
  }
}
