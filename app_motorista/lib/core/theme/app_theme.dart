import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.branco,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.azulPrincipal,
        primary: AppColors.azulPrincipal,
        secondary: AppColors.verdePrincipal,
        surface: AppColors.branco,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.azulPrincipal,
        foregroundColor: AppColors.branco,
        centerTitle: false,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.verdePrincipal,
          foregroundColor: AppColors.branco,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.branco,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
