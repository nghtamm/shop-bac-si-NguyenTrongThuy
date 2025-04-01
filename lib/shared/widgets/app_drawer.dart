import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/constants/app_assets.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/sign_out_usecase.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.primary,
            ),
            child: Center(
              child: Image.asset(AppAssets.logo),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(
              left: 30.w,
              right: 30.w,
              top: 10.h,
            ),
            leading: const Icon(Icons.home_rounded),
            title: Text(
              'Trang chủ',
              style: AppTypography.black['14_semiBold'],
            ),
            onTap: () {
              context.pop();
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 30.w,
            ),
            leading: const Icon(Icons.medication_liquid_rounded),
            title: Text(
              'Tất cả sản phẩm',
              style: AppTypography.black['14_semiBold'],
            ),
            onTap: () {
              context.push(RoutersName.allProducts);
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 30.w,
            ),
            leading: const Icon(Icons.favorite_rounded),
            title: Text(
              'Sản phẩm yêu thích',
              style: AppTypography.black['14_semiBold'],
            ),
            onTap: () {
              context.push(RoutersName.myFavorites);
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 30.w,
            ),
            leading: const Icon(Icons.shopping_cart_rounded),
            title: Text(
              'Giỏ hàng',
              style: AppTypography.black['14_semiBold'],
            ),
            onTap: () {
              context.push(RoutersName.cart);
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 30.w,
            ),
            leading: const Icon(Icons.receipt_rounded),
            title: Text(
              'Hóa đơn',
              style: AppTypography.black['14_semiBold'],
            ),
            onTap: () {
              context.push(RoutersName.orderHistory);
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 30.w,
            ),
            leading: const Icon(Icons.chat_rounded),
            title: Text(
              'Chat với AI',
              style: AppTypography.black['14_semiBold'],
            ),
            onTap: () {
              context.push(RoutersName.chatN8N);
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 30.w,
            ),
            leading: const Icon(Icons.logout_rounded),
            title: Text(
              'Đăng xuất',
              style: AppTypography.black['14_semiBold'],
            ),
            onTap: () async {
              final signOutConfirmation = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'Đăng xuất',
                      style: AppTypography.black['14_bold'],
                    ),
                    content: Text(
                      'Bạn có chắc chắn muốn đăng xuất không?',
                      style: AppTypography.black['14_medium'],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          context.pop(false);
                        },
                        child: Text(
                          'Không',
                          style: AppTypography.black['14_regular']?.copyWith(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          await HydratedBloc.storage.clear();
                          if (context.mounted) {
                            context.pop(true);
                          }
                        },
                        child: Text(
                          'Có',
                          style: AppTypography.black['14_regular']?.copyWith(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );

              if (signOutConfirmation == true) {
                await serviceLocator<SignOutUseCase>().call();

                if (context.mounted) {
                  context.go(RoutersName.onboarding);
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
