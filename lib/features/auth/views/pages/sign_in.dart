import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/data/models/auth_request.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/get_display_name_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/bloc/toggle_password_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                'MUA HÀNG NGAY',
                style: AppTypography.black['32_extraBold'],
              ),
            ),
            SizedBox(height: 5.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Đăng nhập tài khoản để được mua hàng tại Shop Bác sĩ Nguyễn Trọng Thủy',
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
            SizedBox(height: 10.h),
            BlocBuilder<TogglePasswordCubit, bool>(
              builder: (context, isVisible) {
                return TextField(
                  controller: _passwordController,
                  obscureText: !isVisible,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-Z0-9!@#$%^&*()\-_=+<>?]'),
                    ),
                  ],
                  decoration: InputDecoration(
                    hintText: 'Mật khẩu',
                    prefixIcon: const Icon(Icons.password_rounded),
                    suffixIcon: GestureDetector(
                      onTap: () => context
                          .read<TogglePasswordCubit>()
                          .toggleVisibility(),
                      child: Icon(isVisible
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 40.h),
            ElevatedButton(
              onPressed: () async {
                var result = await serviceLocator<SignInUseCase>().call(
                  params: AuthenticationRequest(
                    email: _emailController.text.toString(),
                    password: _passwordController.text.toString(),
                  ),
                );
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
              child: Text(
                'TIẾP TỤC',
                style: AppTypography.white['24_extraBold'],
              ),
            ),
            SizedBox(height: 30.h),
            TextButton(
              onPressed: () {
                context.push(RoutersName.forgotPassword);
              },
              child: Text(
                'Quên mật khẩu?',
                style: AppTypography.black['18_bold'],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
