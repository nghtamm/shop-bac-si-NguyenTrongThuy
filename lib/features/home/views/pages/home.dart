import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/constants/app_assets.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/di/service_locator.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/helpers/text_helpers.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/typography.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/auth/views/bloc/auth_bloc.dart';
import 'package:shop_bacsi_nguyentrongthuy/features/shop/data/sources/product/product_service.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/app_bar.dart';
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

class _HomePageState extends State<HomePage> with RouteAware {
  late ScrollController _scrollController;
  final PageController _pageController = PageController();

  final List<String> bannerImages = [
    AppAssets.saleBanner,
    AppAssets.saleBanner2,
    AppAssets.saleBanner3,
    AppAssets.saleBanner4,
    AppAssets.saleBanner5,
  ];

  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _startAutoScroll();
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

  void _startAutoScroll() {
    _timer = Timer.periodic(
      const Duration(seconds: 4),
      (Timer timer) {
        if (_currentPage < bannerImages.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
        if (_pageController.hasClients) {
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            showLeading: false,
            height: 36.h,
          ),
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
                          serviceLocator<ProductService>().cancelRequest();
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
                        height: 180.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: bannerImages.length,
                            itemBuilder: (context, index) {
                              return Image.asset(
                                bannerImages[index],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              );
                            },
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
              serviceLocator<ProductService>().cancelRequest();
              context.push(RoutersName.allProducts);
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
                  Icons.medical_services_outlined,
                  color: AppColors.black,
                  size: 26,
                ),
                SizedBox(width: 10.w),
                Text(
                  'Sản phẩm',
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
              context.push(RoutersName.cart);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.goldSoft,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Icon(
              Icons.shopping_cart_outlined,
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
              context.push(RoutersName.orderHistory);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.magentaSoft,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Icon(
              Icons.local_mall_outlined,
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
              context.push(RoutersName.chatbot);
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
                  Icons.chat_outlined,
                  color: AppColors.black,
                  size: 26,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Chat với AI',
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
