import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
      ),
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
                'QUÊN MẬT KHẨU',
                style: AppTypography.black['32_extraBold'],
              ),
            ),
            SizedBox(height: 5.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Nhập email của bạn để có thể đặt lại mật khẩu nhé!',
                style: AppTypography.black['18_medium'],
              ),
            ),
            SizedBox(height: 20.h),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Địa chỉ Email',
                prefixIcon: Icon(Icons.email_rounded),
              ),
            ),
            SizedBox(height: 40.h),
            ElevatedButton(
              onPressed: () async {
                var result = await serviceLocator<ResetPasswordUseCase>().call(
                  params: _emailController.text.toString(),
                );
                result.fold(
                  (left) {
                    var snackBar = SnackBar(
                      content: Text(left),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  (right) {
                    var snackBar = SnackBar(
                      content: Text(right),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    context.pop();
                  },
                );
              },
              child: Text(
                'TIẾP TỤC',
                style: AppTypography.white['24_extraBold'],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
