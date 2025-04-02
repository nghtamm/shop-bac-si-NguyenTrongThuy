import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/constants/app_assets.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/text_helpers.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/bloc/auth_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/app_drawer.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/widgets/doctor_choice.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/home/views/widgets/for_your_health.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  final String displayName;

  const HomePage({
    super.key,
    required this.displayName,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  void resetScroll() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
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
          drawer: const AppDrawer(),
          body: Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.only(
                  bottom: 64.h,
                ),
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
                          '''CHÚC ${TextHelpers().formatDisplayName(widget.displayName)}
NGÀY TỐT LÀNH!''',
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
                      child: _firstRowButtons(),
                    ),
                    SizedBox(height: 15.h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 0.h,
                        horizontal: 40.w,
                      ),
                      child: _secondRowButtons(),
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
                            AppAssets.saleBanner,
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

              // Custom 'BottomNavigationBar'
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomBottomNavbar(
                  onTap: resetScroll,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _firstRowButtons() {
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

  Widget _secondRowButtons() {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: ElevatedButton(
            onPressed: () {
              context.push(RoutersName.chatbot);
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
