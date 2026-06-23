import 'package:flutter/material.dart';

import '../../features/auth/admin_login_screen.dart';
import '../../features/comprovantes/comprovantes_screen.dart';
import '../../features/dashboard/dashboard_screen.dart';
import '../../features/fretes/fretes_screen.dart';
import '../../features/motoristas/motoristas_screen.dart';
import '../../features/ordens/ordens_screen.dart';

class AdminRoutes {
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String motoristas = '/motoristas';
  static const String fretes = '/fretes';
  static const String ordens = '/ordens';
  static const String comprovantes = '/comprovantes';

  static Map<String, WidgetBuilder> get routes {
    return {
      login: (_) => const AdminLoginScreen(),
      dashboard: (_) => const DashboardScreen(),
      motoristas: (_) => const MotoristasScreen(),
      fretes: (_) => const FretesScreen(),
      ordens: (_) => const OrdensScreen(),
      comprovantes: (_) => const ComprovantesScreen(),
    };
  }
}
