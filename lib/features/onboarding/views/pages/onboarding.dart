import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/constants/app_assets.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/bloc/auth_bloc.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.go(
            RoutersName.homepage,
            extra: state.displayName,
          );
        }
      },
      builder: (context, state) {
        if (state is AuthInitial || state is AuthLoading) {
          return Shimmer.fromColors(
            baseColor: AppColors.white,
            highlightColor: AppColors.grayLight,
            child: const Scaffold(),
          );
        } else if (state is Unauthenticated) {
          return Scaffold(
            body: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    AppAssets.onboardingBackground,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 50.h,
                    horizontal: 20.w,
                  ),
                  child: SizedBox.expand(
                    child: Column(
                      children: [
                        const Spacer(),
                        Text(
                          'SHOPBACSINGUYENTRONGTHUY',
                          style: AppTypography.black['16_medium'],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'BẢO VỆ SỨC KHỎE,\n NGAY BÂY GIỜ!',
                          style: AppTypography.black['32_extraBold'],
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30.h),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              context.go(RoutersName.authentication);
                            },
                            child: Text(
                              'BẮT ĐẦU',
                              style: AppTypography.white['24_extraBold'],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
