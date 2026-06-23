import 'package:flutter/material.dart';

import 'admin_colors.dart';

class AdminTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AdminColors.cinzaFundo,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AdminColors.azulPrincipal,
        primary: AdminColors.azulPrincipal,
        secondary: AdminColors.verdePrincipal,
        surface: AdminColors.branco,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AdminColors.azulPrincipal,
        foregroundColor: AdminColors.branco,
      ),
      cardTheme: CardThemeData(
        color: AdminColors.branco,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
