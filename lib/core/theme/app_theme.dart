import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/font_weight.dart';
=======
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
>>>>>>> nghtamm2003/refactor

class AppTheme {
  // MODE: Light
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Montserrat',
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
<<<<<<< HEAD
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        elevation: 0,
        minimumSize: const Size(double.infinity, 70),
=======
        overlayColor: AppColors.gray.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        minimumSize: Size(double.infinity, 70.h),
      ).copyWith(
        elevation: WidgetStateProperty.all(0),
>>>>>>> nghtamm2003/refactor
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: AppColors.grayLight,
<<<<<<< HEAD
      contentPadding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 20,
      ),
      labelStyle: const TextStyle(
        color: AppColors.black,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.grayLight,
      contentTextStyle: const TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: AppFontWeight.medium,
        color: AppColors.black,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 2,
=======
      contentPadding: EdgeInsets.symmetric(
        vertical: 18.h,
        horizontal: 20.w,
      ),
    ),
    bannerTheme: const MaterialBannerThemeData(
      elevation: 1,
      backgroundColor: AppColors.transparent,
      shadowColor: AppColors.transparent,
      dividerColor: AppColors.transparent,
>>>>>>> nghtamm2003/refactor
    ),
    drawerTheme: const DrawerThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.transparent,
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    useMaterial3: true,
  );

  // MODE: Dark (Currently not available)
}
