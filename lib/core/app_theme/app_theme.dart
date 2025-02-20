import 'package:evently/core/app_theme/app_color.dart';
import 'package:flutter/material.dart';
//end

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: AppColor.lightBackground,
      primaryColor: AppColor.primaryColor,
      primaryColorLight: AppColor.white,
      primaryColorDark: AppColor.black,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColor.primaryColor,
        foregroundColor: AppColor.white,
          elevation: 0
      ),
      textTheme: const TextTheme(
        bodySmall: TextStyle(color: AppColor.black, fontSize: 14),
        bodyMedium: TextStyle(color: AppColor.black, fontSize: 18),
        bodyLarge: TextStyle(color: AppColor.black, fontSize: 20),
      ));
  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: AppColor.darkBackground,
      primaryColor: AppColor.primaryColor,
      primaryColorLight: AppColor.black,
      primaryColorDark: AppColor.white,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColor.primaryColor,
          foregroundColor: AppColor.white,
        elevation: 0
      ),
      textTheme: const TextTheme(
        bodySmall: TextStyle(color: AppColor.white, fontSize: 14),
        bodyMedium: TextStyle(color: AppColor.white, fontSize: 18),
        bodyLarge: TextStyle(color: AppColor.white, fontSize: 20),
      ));
}
