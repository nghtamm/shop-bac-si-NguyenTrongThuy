import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/constants/app_assets.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/local/global_storage.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/bloc/auth_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/app_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = serviceLocator<GlobalStorage>().user;

    return Scaffold(
      body: Stack(
        children: [
          // Profile Background
          Container(
            height: 0.25.sh,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AppAssets.profileBackground,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Contents
          Column(
            children: [
              SizedBox(height: 0.185.sh),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 56,
                      backgroundColor: AppColors.white,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                          AppAssets.capybara,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Chào bạn',
                      style: AppTypography.black['22_medium'],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      user?.displayName!.toUpperCase() ?? 'NGƯỜI DÙNG KHÁCH',
                      style: AppTypography.black['26_extraBold'],
                    ),
                    SizedBox(height: 24.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              context.pushReplacement(RoutersName.allProducts);
                            },
                            style: TextButton.styleFrom(
                              overlayColor: AppColors.grayNeutral,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 12.h,
                                horizontal: 30.w,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.medication_liquid_rounded,
                                  color: AppColors.black,
                                  size: 26,
                                ),
                                SizedBox(width: 14.w),
                                Text(
                                  'Tất cả sản phẩm',
                                  style: AppTypography.black['18_medium'],
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              overlayColor: AppColors.grayNeutral,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 12.h,
                                horizontal: 30.w,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.newspaper_rounded,
                                  color: AppColors.black,
                                  size: 26,
                                ),
                                SizedBox(width: 14.w),
                                Text(
                                  'Chăm sóc sức khỏe',
                                  style: AppTypography.black['18_medium'],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            indent: 30.w,
                            endIndent: 30.w,
                          ),
                          TextButton(
                            onPressed: () {
                              context.pushReplacement(RoutersName.orderHistory);
                            },
                            style: TextButton.styleFrom(
                              overlayColor: AppColors.grayNeutral,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 12.h,
                                horizontal: 30.w,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.shopping_bag_rounded,
                                  color: AppColors.black,
                                  size: 26,
                                ),
                                SizedBox(width: 14.w),
                                Text(
                                  'Đơn mua',
                                  style: AppTypography.black['18_medium'],
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.pushReplacement(RoutersName.cart);
                            },
                            style: TextButton.styleFrom(
                              overlayColor: AppColors.grayNeutral,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 12.h,
                                horizontal: 30.w,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.shopping_cart_rounded,
                                  color: AppColors.black,
                                  size: 26,
                                ),
                                SizedBox(width: 14.w),
                                Text(
                                  'Giỏ hàng',
                                  style: AppTypography.black['18_medium'],
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.pushReplacement(RoutersName.myFavorites);
                            },
                            style: TextButton.styleFrom(
                              overlayColor: AppColors.grayNeutral,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 12.h,
                                horizontal: 30.w,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.favorite_rounded,
                                  color: AppColors.black,
                                  size: 26,
                                ),
                                SizedBox(width: 14.w),
                                Text(
                                  'Sản phẩm yêu thích',
                                  style: AppTypography.black['18_medium'],
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.pushReplacement(RoutersName.chatbot);
                            },
                            style: TextButton.styleFrom(
                              overlayColor: AppColors.grayNeutral,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 12.h,
                                horizontal: 30.w,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.chat_bubble_rounded,
                                  color: AppColors.black,
                                  size: 26,
                                ),
                                SizedBox(width: 14.w),
                                Text(
                                  'Tư vấn sức khỏe',
                                  style: AppTypography.black['18_medium'],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            indent: 30.w,
                            endIndent: 30.w,
                          ),
                          TextButton(
                            onPressed: () async {
                              final confirmation = await showDialog<bool>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Đăng xuất',
                                      style: AppTypography.black['20_bold'],
                                    ),
                                    content: Text(
                                      'Bạn có chắc chắn muốn đăng xuất không?',
                                      style: AppTypography.black['16_medium'],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          context.pop(false);
                                        },
                                        child: Text(
                                          'Không',
                                          style:
                                              AppTypography.black['16_medium'],
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context.pop(true);
                                        },
                                        child: Text(
                                          'Có',
                                          style: AppTypography
                                              .black['16_semiBold']
                                              ?.copyWith(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );

                              if (confirmation == true) {
                                if (context.mounted) {
                                  context.read<AuthBloc>().add(
                                        SignOutRequested(),
                                      );
                                  context.go(RoutersName.onboarding);
                                }
                              }
                            },
                            style: TextButton.styleFrom(
                              overlayColor: AppColors.grayNeutral,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 12.h,
                                horizontal: 30.w,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.logout_rounded,
                                  color: Colors.red,
                                  size: 26,
                                ),
                                SizedBox(width: 14.w),
                                Text(
                                  'Đăng xuất',
                                  style: AppTypography.black['18_semiBold']!
                                      .copyWith(
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // AppBar
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomAppBar(
              showLeading: true,
            ),
          ),
        ],
      ),
    );
  }
}
