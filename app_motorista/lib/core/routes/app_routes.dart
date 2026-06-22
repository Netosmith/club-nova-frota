import 'package:flutter/material.dart';

import '../../features/auth/login_screen.dart';
import '../../features/comprovantes/comprovantes_screen.dart';
import '../../features/fretes/fretes_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/ordens/ordens_screen.dart';
import '../../features/perfil/perfil_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String fretes = '/fretes';
  static const String ordens = '/ordens';
  static const String comprovantes = '/comprovantes';
  static const String perfil = '/perfil';

  static Map<String, WidgetBuilder> get routes {
    return {
      login: (_) => const LoginScreen(),
      home: (_) => const HomeScreen(),
      fretes: (_) => const FretesScreen(),
      ordens: (_) => const OrdensScreen(),
      comprovantes: (_) => const ComprovantesScreen(),
      perfil: (_) => const PerfilScreen(),
    };
  }
}
