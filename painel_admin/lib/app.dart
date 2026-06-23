import 'package:flutter/material.dart';

import 'core/theme/admin_theme.dart';
import 'features/dashboard/dashboard_screen.dart';

class PainelAdminApp extends StatelessWidget {
  const PainelAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Painel Admin - Club Nova Frota',
      debugShowCheckedModeBanner: false,
      theme: AdminTheme.light,
      home: const DashboardScreen(),
    );
  }
}
