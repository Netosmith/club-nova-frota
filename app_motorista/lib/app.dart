import 'package:flutter/material.dart';

import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/login_screen.dart';

class ClubNovaFrotaApp extends StatelessWidget {
  const ClubNovaFrotaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Club Nova Frota',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routes: AppRoutes.routes,
      home: const LoginScreen(),
    );
  }
}
