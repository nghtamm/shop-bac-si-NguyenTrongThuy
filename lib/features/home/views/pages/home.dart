import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/widgets/doctor_choice.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/widgets/for_your_health.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';

class HomePage extends StatelessWidget {
  final String displayName;

  const HomePage({super.key, required this.displayName});

  String get formattedDisplayName =>
      displayName.trim().split(' ').last.toUpperCase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu_rounded),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: AppColors.primary,
              ),
              child: Center(
                child: Image.asset('assets/images/shop_logo.png'),
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
                context.push(RoutersName.aiChat);
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
                    context.go(RoutersName.getStarted);
                  }
                }
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20.h,
                horizontal: 40.w,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'CHÚC $formattedDisplayName\nNGÀY TỐT LÀNH!',
                  style: AppTypography.black['32_extraBold'],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 0.h,
                horizontal: 40.w,
              ),
              child: TextField(
                onTap: () {
                  context.push(RoutersName.search);
                },
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm',
                  suffixIcon: const Icon(Icons.search_rounded),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 15.w,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 0.h,
                horizontal: 40.w,
              ),
              child: _FirstRowButtons(),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 0.h,
                horizontal: 40.w,
              ),
              child: _SecondRowButtons(),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 0.h,
                horizontal: 40.w,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/sale_banner.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 0.h,
                horizontal: 40.w,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'BÁC SĨ TIN DÙNG!',
                  style: AppTypography.black['32_extraBold'],
                ),
              ),
            ),
            const DoctorChoice(),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 0.h,
                horizontal: 40.w,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'BẢO VỆ SỨC KHỎE CỦA BẠN!',
                  style: AppTypography.black['32_extraBold'],
                ),
              ),
            ),
            const ForYourHealth(),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}

class _FirstRowButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: ElevatedButton(
            onPressed: () {
              context.push(RoutersName.cart);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.shopping_cart_outlined,
                  color: AppColors.black,
                  size: 26,
                ),
                SizedBox(width: 10.w),
                Text(
                  'Giỏ hàng',
                  style: AppTypography.black['20_bold'],
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 15.w),
        Flexible(
          flex: 1,
          child: ElevatedButton(
            onPressed: () {
              context.push(RoutersName.allProducts);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.goldSoft,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Icon(
              Icons.medication_liquid_sharp,
              color: AppColors.black,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}

class _SecondRowButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: ElevatedButton(
            onPressed: () {
              context.push(RoutersName.aiChat);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.magentaSoft,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Icon(
              Icons.chat_bubble_outline_rounded,
              color: AppColors.black,
              size: 30,
            ),
          ),
        ),
        SizedBox(width: 15.w),
        Flexible(
          flex: 2,
          child: ElevatedButton(
            onPressed: () {
              context.push(RoutersName.orderHistory);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.cyanSoft,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.receipt_outlined,
                  color: AppColors.black,
                  size: 26,
                ),
                SizedBox(width: 10.w),
                Text(
                  'Hóa đơn',
                  style: AppTypography.black['20_bold'],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
