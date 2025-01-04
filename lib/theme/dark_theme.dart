import 'package:flutter/material.dart';
import 'package:taskmate/theme/app_colors.dart';
import 'package:taskmate/theme/app_text_styles.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.darkPrimary,
  scaffoldBackgroundColor: AppColors.darkBackground,
  colorScheme: ColorScheme.dark(
    primary: AppColors.darkPrimary,
    secondary: AppColors.darkAccent,
    background: AppColors.darkBackground,
    surface: AppColors.darkSurface,
    error: AppColors.darkError,
    onPrimary: AppColors.onDarkPrimary,
    onSecondary: AppColors.onDarkAccent,
    onBackground: AppColors.onDarkBackground,
    onSurface: AppColors.onDarkSurface,
    onError: AppColors.darkError,
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      color: AppColors.onDarkBackground,
      fontFamily: "Roboto",
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    color: AppColors.darkSurface,
    iconTheme: IconThemeData(color: AppColors.onDarkSurface),
  ),
  textTheme: const TextTheme(
    headlineLarge: AppTextStyles.darkScreenHeadingLargeTextStyle,
    headlineMedium: AppTextStyles.darkScreenHeadingMediumTextStyle,
    headlineSmall: AppTextStyles.darkScreenHeadingSmallTextStyle,
    bodyLarge: AppTextStyles.darkScreenBodyLargeTextStyle,
    bodyMedium: AppTextStyles.darkScreenBodyMediumTextStyle,
    bodySmall: AppTextStyles.darkScreenBodySmallTextStyle,
    labelLarge: AppTextStyles.darkScreenLabelLargeTextStyle,
    labelMedium: AppTextStyles.darkScreenLabelMediumTextStyle,
    labelSmall: AppTextStyles.darkScreenLabelSmallTextStyle,
  ),
  dividerTheme: DividerThemeData(color: AppColors.darkText),
);
