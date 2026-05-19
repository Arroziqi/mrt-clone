import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_text_style.dart';

class AppTheme {
  static const primaryColor = AppColors.primaryBlue;

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.inter().fontFamily,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryBlue,
      onPrimary: AppColors.surface,
      secondary: AppColors.primaryGreen,
      onSecondary: AppColors.surface,
      surface: AppColors.surface,
      error: Colors.red,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.primaryBlue,
      foregroundColor: AppColors.surface,
      elevation: 0,
      titleTextStyle: AppTextStyle.title.copyWith(color: AppColors.surface),
      iconTheme: const IconThemeData(color: AppColors.surface),
    ),
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.zero,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: AppTextStyle.button,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: const BorderSide(color: AppColors.primaryBlue),
        textStyle: AppTextStyle.button.copyWith(color: AppColors.primaryBlue),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryBlue),
      ),
      hintStyle: AppTextStyle.body.copyWith(color: AppColors.textSecondary),
    ),
    textTheme: TextTheme(
      displayLarge: AppTextStyle.headline,
      titleLarge: AppTextStyle.title,
      bodyLarge: AppTextStyle.body,
      bodyMedium: AppTextStyle.bodySmall,
      labelLarge: AppTextStyle.button,
    ),
  );
}
