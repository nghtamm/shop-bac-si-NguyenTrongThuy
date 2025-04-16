import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/text_helpers.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/bloc/auth_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/app_bar.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  String? _emailError;

  bool get isFormValid =>
      _emailController.text.trim().isNotEmpty &&
      _emailError == null &&
      TextHelpers().validateEmail(_emailController.text);

  @override
  void initState() {
    super.initState();

    _emailController.addListener(
      () => setState(() {
        final email = _emailController.text.trim();

        if (email.isEmpty) {
          _emailError = null;
        } else if (!TextHelpers().validateEmail(email)) {
          _emailError = 'Định dạng email không hợp lệ';
        } else {
          _emailError = null;
        }
      }),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

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
                decoration: InputDecoration(
                  hintText: 'Địa chỉ Email',
                  prefixIcon: const Icon(
                    Icons.email_rounded,
                  ),
                  errorText: _emailError,
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
                          title: 'Đặt lại mật khẩu',
                          message: state.message,
                          contentType: ContentType.failure,
                          inMaterialBanner: true,
                        ),
                        actions: const [
                          SizedBox.shrink(),
                        ],
                      ),
                    );

                    Future.delayed(const Duration(milliseconds: 2000), () {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).clearMaterialBanners();
                      }
                    });
                  } else if (state is PasswordResetSuccess) {
                    ScaffoldMessenger.of(context).showMaterialBanner(
                      MaterialBanner(
                        forceActionsBelow: true,
                        content: AwesomeSnackbarContent(
                          title: 'Đặt lại mật khẩu',
                          message: state.message,
                          contentType: ContentType.success,
                          inMaterialBanner: true,
                        ),
                        actions: const [
                          SizedBox.shrink(),
                        ],
                      ),
                    );
                    context.pop();
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    context.loaderOverlay.show();
                  } else {
                    context.loaderOverlay.hide();
                  }

                  return ElevatedButton(
                    onPressed: isFormValid
                        ? () {
                            context.read<AuthBloc>().add(
                                  ForgotPasswordRequested(
                                    email: _emailController.text.trim(),
                                  ),
                                );
                          }
                        : null,
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
