import 'package:flutter/material.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/app_colors.dart';
import 'package:shop_bacsi_nguyentrongthuy/core/theme/font_weight.dart';

class AppTypography {
  static TextStyle _textStyle(double size, FontWeight weight, Color color) {
    return TextStyle(
      fontSize: size,
      fontWeight: weight,
      color: color,
    );
  }

  static const List<double> fontSizes = [
    12,
    14,
    16,
    18,
    20,
    22,
    24,
    26,
    28,
    32,
  ];

  static const Map<String, FontWeight> fontWeights = {
    // 'thin': FontWeight.w100,
    'thin': AppFontWeight.thin,
    // 'extraLight': FontWeight.w200,
    'extraLight': AppFontWeight.extraLight,
    // 'light': FontWeight.w300,
    'light': AppFontWeight.light,
    // 'regular': FontWeight.w400,
    'regular': AppFontWeight.regular,
    // 'medium': FontWeight.w500,
    'medium': AppFontWeight.medium,
    // 'semiBold': FontWeight.w600,
    'semiBold': AppFontWeight.semiBold,
    // 'bold': FontWeight.w700,
    'bold': AppFontWeight.bold,
    // 'extraBold': FontWeight.w800,
    'extraBold': AppFontWeight.extraBold,
    // 'black': FontWeight.w900,
    'black': AppFontWeight.black,
  };

  static Map<String, TextStyle> generateTypography(Color color) {
    final Map<String, TextStyle> style = {};
    for (var size in fontSizes) {
      for (var weight in fontWeights.keys) {
        String key = '${size.toInt()}_$weight';
        style[key] = _textStyle(size, fontWeights[weight]!, color);
      }
    }
    return style;
  }

  static final black = generateTypography(
    AppColors.black,
  );
  static final white = generateTypography(
    AppColors.white,
  );
}
