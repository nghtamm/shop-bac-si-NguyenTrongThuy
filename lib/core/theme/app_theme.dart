import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';

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
        overlayColor: AppColors.gray.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        minimumSize: const Size(double.infinity, 70),
      ).copyWith(
        elevation: WidgetStateProperty.all(0),
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
      contentPadding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 20,
      ),
    ),
    bannerTheme: const MaterialBannerThemeData(
      elevation: 1,
      backgroundColor: AppColors.transparent,
      shadowColor: AppColors.transparent,
      dividerColor: AppColors.transparent,
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
