//TODO: Define the color scheme for the app

import 'package:flutter/material.dart';
import 'colors.dart';

final ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme(
    primary: AppColors.primaryColor,
    primaryContainer: AppColors.primaryVariantColor,
    secondary: AppColors.secondaryColor,
    secondaryContainer: AppColors.secondaryVariantColor,
    surface: AppColors.surfaceColor,
    error: AppColors.errorColor,
    onPrimary: AppColors.onPrimaryColor,
    onSecondary: AppColors.onSecondaryColor,
    onSurface: AppColors.onSurfaceColor,
    onError: AppColors.onErrorColor,
    brightness: Brightness.light, // Change to Brightness.dark for dark theme
  ),
  // Define default font family, icon theme, etc. if needed
  textTheme: TextTheme(
    bodySmall: TextStyle(color: AppColors.onBackgroundColor),
    bodyMedium: TextStyle(color: AppColors.onBackgroundColor),
    bodyLarge: TextStyle(color: AppColors.onBackgroundColor),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: AppColors.primaryColor,
    textTheme: ButtonTextTheme.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: AppColors.primaryColor,
      backgroundColor: AppColors.onPrimaryColor,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primaryColor,
      side: BorderSide(color: AppColors.primaryColor),
    ),
  ),
  // Other theme settings if needed
);
