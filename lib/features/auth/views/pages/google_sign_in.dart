import 'dart:async';

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

class GoogleSignInPage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const GoogleSignInPage({
    super.key,
    required this.userData,
  });

  @override
  State<GoogleSignInPage> createState() => _GoogleSignInPageState();
}

class _GoogleSignInPageState extends State<GoogleSignInPage> {
  final completer = Completer<void>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _passwordError;

  bool get isFormValid =>
      _firstNameController.text.trim().isNotEmpty &&
      _lastNameController.text.trim().isNotEmpty &&
      _displayNameController.text.trim().isNotEmpty &&
      _emailController.text.trim().isNotEmpty &&
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
      () => setState(() {}),
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
    _firstNameController.text = widget.userData['first_name'] ?? '';
    _lastNameController.text = widget.userData['last_name'] ?? '';
    _displayNameController.text = widget.userData['display_name'] ?? '';
    _emailController.text = widget.userData['email'] ?? '';

    return BlocProvider(
      create: (context) => TogglePasswordCubit(),
      child: LoaderOverlay(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: const CustomAppBar(
            showLeading: false,
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
                    'ĐĂNG NHẬP BẰNG GOOGLE',
                    style: AppTypography.black['32_extraBold'],
                  ),
                ),
                SizedBox(height: 5.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Nhập mật khẩu để hoàn tất quá trình đăng nhập bằng tài khoản Google',
                    style: AppTypography.black['18_medium'],
                  ),
                ),
                SizedBox(height: 10.h),
                TextField(
                  readOnly: true,
                  controller: _lastNameController,
                  style: const TextStyle(
                    color: AppColors.gray,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Họ của bạn',
                    prefixIcon: Icon(
                      Icons.person_rounded,
                      color: AppColors.gray,
                    ),
                    fillColor: AppColors.grayNeutral,
                  ),
                ),
                SizedBox(height: 10.h),
                TextField(
                  readOnly: true,
                  controller: _firstNameController,
                  style: const TextStyle(
                    color: AppColors.gray,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Tên của bạn',
                    prefixIcon: Icon(
                      Icons.person_rounded,
                      color: AppColors.gray,
                    ),
                    fillColor: AppColors.grayNeutral,
                  ),
                ),
                SizedBox(height: 10.h),
                TextField(
                  readOnly: true,
                  controller: _displayNameController,
                  style: const TextStyle(
                    color: AppColors.gray,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Chúng tôi nên gọi bạn là gì?',
                    prefixIcon: Icon(
                      Icons.switch_account_rounded,
                      color: AppColors.gray,
                    ),
                    fillColor: AppColors.grayNeutral,
                  ),
                ),
                SizedBox(height: 10.h),
                TextField(
                  readOnly: true,
                  controller: _emailController,
                  style: const TextStyle(
                    color: AppColors.gray,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Địa chỉ email',
                    prefixIcon: Icon(
                      Icons.email_rounded,
                      color: AppColors.gray,
                    ),
                    fillColor: AppColors.grayNeutral,
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
                            title: 'Đăng nhập bằng Google',
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
                    }

                    return ElevatedButton(
                      onPressed: isFormValid
                          ? () async {
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
                                      completer: completer,
                                    ),
                                  );
                              await completer.future;

                              // ignore: use_build_context_synchronously
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
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
