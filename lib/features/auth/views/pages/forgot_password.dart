import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/bloc/auth_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/app_bar.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(),
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
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthFailure) {
                    ScaffoldMessenger.of(context).showMaterialBanner(
                      MaterialBanner(
                        forceActionsBelow: true,
                        content: AwesomeSnackbarContent(
                          title: 'Đã xảy ra lỗi',
                          message: state.message,
                          contentType: ContentType.failure,
                          inMaterialBanner: true,
                        ),
                        actions: const [
                          SizedBox.shrink(),
                        ],
                      ),
                    );

                    Future.delayed(const Duration(milliseconds: 1500), () {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).clearMaterialBanners();
                      }
                    });
                  } else if (state is PasswordResetSuccess) {
                    ScaffoldMessenger.of(context).showMaterialBanner(
                      MaterialBanner(
                        forceActionsBelow: true,
                        content: AwesomeSnackbarContent(
                          title: 'Quên mật khẩu',
                          message: state.message,
                          contentType: ContentType.success,
                          inMaterialBanner: true,
                        ),
                        actions: const [
                          SizedBox.shrink(),
                        ],
                      ),
                    );

                    Future.delayed(const Duration(milliseconds: 1500), () {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).clearMaterialBanners();
                        context.pop();
                      }
                    });
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    context.loaderOverlay.show();
                  } else {
                    context.loaderOverlay.hide();
                  }

                  return ElevatedButton(
                    onPressed: () => context.read<AuthBloc>().add(
                          ForgotPasswordRequested(
                            email: _emailController.text.trim(),
                          ),
                        ),
                    child: Text(
                      'TIẾP TỤC',
                      style: AppTypography.white['24_extraBold'],
                    ),
                  );
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
