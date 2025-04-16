import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/formatters/password_formatter.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/text_helpers.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/bloc/auth_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/cubit/toggle_password_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/app_bar.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailError;

  bool get isFormValid =>
      _emailController.text.trim().isNotEmpty &&
      _emailError == null &&
      _passwordController.text.trim().isNotEmpty;

  bool _hasHandledExtra = false;

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
    _passwordController.addListener(
      () => setState(() {}),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_hasHandledExtra) return;

    final extra = GoRouterState.of(context).extra as Map?;
    if (extra != null && extra['showBanner'] == true) {
      _hasHandledExtra = true;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showMaterialBanner(
          MaterialBanner(
            forceActionsBelow: true,
            content: AwesomeSnackbarContent(
              title: 'Đăng ký tài khoản',
              message: extra['message'],
              contentType: ContentType.success,
              inMaterialBanner: true,
            ),
            actions: const [
              SizedBox.shrink(),
            ],
          ),
        );

        Future.delayed(const Duration(milliseconds: 2000), () {
          if (!mounted) return;
          ScaffoldMessenger.of(context).clearMaterialBanners();
        });
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TogglePasswordCubit(),
      child: LoaderOverlay(
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
                  decoration: InputDecoration(
                    hintText: 'Địa chỉ email',
                    prefixIcon: const Icon(
                      Icons.email_rounded,
                    ),
                    errorText: _emailError,
                  ),
                ),
                SizedBox(height: 10.h),
                BlocBuilder<TogglePasswordCubit, bool>(
                  builder: (context, isVisible) {
                    return TextField(
                      controller: _passwordController,
                      obscureText: !isVisible,
                      inputFormatters: [
                        passwordFormatter(),
                      ],
                      decoration: InputDecoration(
                        hintText: 'Mật khẩu',
                        prefixIcon: const Icon(
                          Icons.password_rounded,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () => context
                              .read<TogglePasswordCubit>()
                              .toggleVisibility(),
                          child: Icon(
                            isVisible
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 40.h),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    Future.delayed(const Duration(milliseconds: 2000), () {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).clearMaterialBanners();
                      }
                    });

                    if (state is AuthFailure) {
                      ScaffoldMessenger.of(context).showMaterialBanner(
                        MaterialBanner(
                          forceActionsBelow: true,
                          content: AwesomeSnackbarContent(
                            title: 'Đăng nhập',
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
                    } else if (state is Authenticated) {
                      context.go(
                        RoutersName.homepage,
                        extra: state.displayName,
                      );
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
                                    SignInRequested(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
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
                SizedBox(height: 10.h),
                TextButton(
                  onPressed: () {
                    context.push(RoutersName.forgotPassword);
                  },
                  style: TextButton.styleFrom(
                    minimumSize: Size(double.infinity, 70.h),
                  ),
                  child: Text(
                    'Quên mật khẩu?',
                    style: AppTypography.black['18_bold'],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
