import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/text_helpers.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/formatters/password_formatter.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/bloc/auth_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/cubit/toggle_password_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/app_bar.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;

  bool get isFormValid =>
      _firstNameController.text.trim().isNotEmpty &&
      _lastNameController.text.trim().isNotEmpty &&
      _displayNameController.text.trim().isNotEmpty &&
      _emailController.text.trim().isNotEmpty &&
      _emailError == null &&
      _passwordController.text.trim().isNotEmpty &&
      _passwordError == null;

  @override
  void initState() {
    super.initState();

    _firstNameController.addListener(
      () => setState(() {}),
    );
    _lastNameController.addListener(
      () => setState(() {}),
    );
    _displayNameController.addListener(
      () => setState(() {}),
    );
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
      () => setState(() {
        final password = _passwordController.text.trim();

        if (password.isEmpty) {
          _passwordError = null;
        } else if (!TextHelpers().validatePassword(password)) {
          _passwordError = 'Mật khẩu phải chứa ít nhất 8 ký tự';
        } else {
          _passwordError = null;
        }
      }),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _displayNameController.dispose();
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'BẠN LÀ AI?',
                    style: AppTypography.black['32_extraBold'],
                  ),
                ),
                SizedBox(height: 5.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Cung cấp thông tin cá nhân của bạn để chúng tôi có thể phục vụ tốt hơn!',
                    style: AppTypography.black['18_medium'],
                  ),
                ),
                SizedBox(height: 10.h),
                TextField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    hintText: 'Họ của bạn',
                    prefixIcon: Icon(
                      Icons.person_rounded,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                TextField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    hintText: 'Tên của bạn',
                    prefixIcon: Icon(
                      Icons.person_rounded,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                TextField(
                  controller: _displayNameController,
                  decoration: const InputDecoration(
                    hintText: 'Chúng tôi nên gọi bạn là gì?',
                    prefixIcon: Icon(
                      Icons.switch_account_rounded,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
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
                            color: AppColors.black,
                          ),
                        ),
                        errorText: _passwordError,
                      ),
                    );
                  },
                ),
                SizedBox(height: 40.h),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthFailure) {
                      context.loaderOverlay.hide();

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
                    } else if (state is Unauthenticated) {
                      ScaffoldMessenger.of(context).showMaterialBanner(
                        const MaterialBanner(
                          forceActionsBelow: true,
                          content: AwesomeSnackbarContent(
                            title: 'Đăng ký thành công',
                            message:
                                'Vui lòng đăng nhập để tiếp tục sử dụng ứng dụng!',
                            contentType: ContentType.success,
                            inMaterialBanner: true,
                          ),
                          actions: [
                            SizedBox.shrink(),
                          ],
                        ),
                      );

                      Future.delayed(const Duration(milliseconds: 1500), () {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).clearMaterialBanners();
                          context.loaderOverlay.hide();
                          context.replace(RoutersName.signIn);
                        }
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      context.loaderOverlay.show();
                    }

                    return ElevatedButton(
                      onPressed: isFormValid
                          ? () {
                              context.read<AuthBloc>().add(
                                    SignUpRequested(
                                      firstName:
                                          _firstNameController.text.trim(),
                                      lastName: _lastNameController.text.trim(),
                                      displayName:
                                          _displayNameController.text.trim(),
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                      userLogin: TextHelpers().formatUserLogin(
                                        _displayNameController.text.trim(),
                                      ),
                                      userNicename:
                                          TextHelpers().formatUserNicename(
                                        _displayNameController.text.trim(),
                                      ),
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
      ),
    );
  }
}
