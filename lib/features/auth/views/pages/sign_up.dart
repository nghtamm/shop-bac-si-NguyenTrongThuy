import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
<<<<<<< HEAD
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/data/models/auth_request.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/bloc/toggle_password_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
=======
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/formatters/password_formatter.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/bloc/auth_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/cubit/toggle_password_cubit.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/app_bar.dart';
>>>>>>> nghtamm2003/refactor

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
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
                'BẠN LÀ AI?',
                style: AppTypography.black['32_extraBold'],
              ),
            ),
            SizedBox(height: 5.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Hãy nhập thông tin cá nhân của bạn để chúng tôi có thể phục vụ tốt hơn!',
                style: AppTypography.black['18_medium'],
              ),
            ),
            SizedBox(height: 20.h),
            TextField(
              controller: _displayNameController,
              decoration: const InputDecoration(
                hintText: 'Họ và tên',
                prefixIcon: Icon(Icons.person_rounded),
              ),
            ),
            SizedBox(height: 10.h),
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
                var result = await serviceLocator<SignUpUseCase>().call(
                  params: AuthenticationRequest(
                    displayName: _displayNameController.text.toString(),
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
                    var snackBar = SnackBar(
                      content: Text(right),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    final user = FirebaseAuth.instance.currentUser;
                    await user?.updateDisplayName(_displayNameController.text);

                    if (context.mounted) {
                      context.go(RoutersName.signIn);
                    }
                  },
                );
              },
              child: Text(
                'TIẾP TỤC',
                style: AppTypography.white['24_extraBold'],
              ),
=======
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
                SizedBox(height: 20.h),
                TextField(
                  controller: _displayNameController,
                  decoration: const InputDecoration(
                    hintText: 'Họ và tên',
                    prefixIcon: Icon(Icons.person_rounded),
                  ),
                ),
                SizedBox(height: 10.h),
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
                        passwordFormatter(),
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
                            message: 'Đăng nhập để tiếp tục sử dụng ứng dụng!',
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
                      onPressed: () => context.read<AuthBloc>().add(
                            SignUpRequested(
                              displayName: _displayNameController.text.trim(),
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
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
>>>>>>> nghtamm2003/refactor
            ),
          ),
        ),
      ),
    );
  }
}
