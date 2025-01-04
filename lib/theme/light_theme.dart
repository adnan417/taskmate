import 'package:flutter/material.dart';
import 'package:taskmate/theme/app_colors.dart';
import 'package:taskmate/theme/app_text_styles.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.lightPrimary,
  scaffoldBackgroundColor: AppColors.lightBackground,
  colorScheme: ColorScheme.light(
    primary: AppColors.lightPrimary,
    secondary: AppColors.lightAccent,
    background: AppColors.lightBackground,
    surface: AppColors.lightSurface,
    error: AppColors.lightError,
    onPrimary: AppColors.onLightPrimary,
    onSecondary: AppColors.onLightAccent,
    onBackground: AppColors.onLightBackground,
    onSurface: AppColors.onLightSurface,
    onError: AppColors.lightError,
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      color: AppColors.onLightBackground,
      fontFamily: "Roboto",
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    color: AppColors.lightSurface,
    iconTheme: IconThemeData(color: AppColors.onLightSurface),
  ),
  textTheme: const TextTheme(
    headlineLarge: AppTextStyles.lightScreenHeadingLargeTextStyle,
    headlineMedium: AppTextStyles.lightScreenHeadingMediumTextStyle,
    headlineSmall: AppTextStyles.lightScreenHeadingSmallTextStyle,
    bodyLarge: AppTextStyles.lightScreenBodyLargeTextStyle,
    bodyMedium: AppTextStyles.lightScreenBodyMediumTextStyle,
    bodySmall: AppTextStyles.lightScreenBodySmallTextStyle,
    labelLarge: AppTextStyles.lightScreenLabelLargeTextStyle,
    labelMedium: AppTextStyles.lightScreenLabelMediumTextStyle,
    labelSmall: AppTextStyles.lightScreenLabelSmallTextStyle,
  ),
  dividerTheme: DividerThemeData(color: AppColors.lightText),
);
