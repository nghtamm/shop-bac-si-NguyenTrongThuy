import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    fontFamily: 'Montserrat',
    primaryColor: const Color(0xFF43B73B),
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF43B73B),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        minimumSize: const Size(double.infinity, 70),
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
      fillColor: const Color(0xFFF0F0F0),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 20,
      ),
      labelStyle: const TextStyle(color: Colors.black),
    ),
    useMaterial3: true,
  );
}
