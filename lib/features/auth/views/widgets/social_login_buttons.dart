import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/constants/app_assets.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/bloc/auth_bloc.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
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
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () =>
                  context.read<AuthBloc>().add(GoogleSignInRequested()),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blueGray,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                minimumSize: Size(90.w, 50.h),
              ),
              child: SvgPicture.asset(
                AppAssets.googleIcon,
                height: 24.h,
                width: 24.h,
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blueGray,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                minimumSize: Size(90.w, 50.h),
              ),
              child: SvgPicture.asset(
                AppAssets.appleIcon,
                height: 24.h,
                width: 24.h,
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blueGray,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                minimumSize: Size(90.w, 50.h),
              ),
              child: SvgPicture.asset(
                AppAssets.facebookIcon,
                height: 24.h,
                width: 24.h,
              ),
            ),
          ],
        );
      },
    );
  }
}
