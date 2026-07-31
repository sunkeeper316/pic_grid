import 'package:flutter/material.dart';

import 'app_colors.dart';

/// App Styles Class -> Resource class for storing app level styles constants
class AppStyles {

  // Light Theme
  static ThemeData lightTheme(){
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      primaryColor: AppColors.primaryColor,
      primaryColorLight: AppColors.primaryColorLight,
      primaryColorDark: AppColors.primaryColorDark,
      inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.all(16),
        hintStyle: TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.normal,
        ),
        labelStyle: TextStyle(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
        ),
        errorStyle: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primaryColorDark,
              width: 2.5,
            ),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12))
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: 2.5,
            ),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12))
        ),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 2.5,
            ),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12))
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2.5,
            ),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12))
        ),
      ),
      buttonTheme: const ButtonThemeData(
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          )
        ),
        textTheme:ButtonTextTheme.normal,
        buttonColor: AppColors.accentColor,
      ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.accentColor),
    );
  }

  // Dark Theme
  static ThemeData darkTheme(){
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      primaryColor: AppColors.primaryColor,
      primaryColorLight: AppColors.primaryColorLight,
      primaryColorDark: AppColors.primaryColorDark, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.accentColor),
    );
  }

}