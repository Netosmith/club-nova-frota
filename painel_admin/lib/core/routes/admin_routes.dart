import 'package:flutter/material.dart';

import '../../features/auth/admin_login_screen.dart';
import '../../features/avisos/avisos_screen.dart';
import '../../features/beneficios/beneficios_screen.dart';
import '../../features/chamados/chamados_screen.dart';
import '../../features/comprovantes/comprovantes_screen.dart';
import '../../features/configuracoes/configuracoes_screen.dart';
import '../../features/dashboard/dashboard_screen.dart';
import '../../features/fretes/fretes_screen.dart';
import '../../features/motoristas/motoristas_screen.dart';
import '../../features/ordens/ordens_screen.dart';
import '../../features/pontos/pontos_screen.dart';
import '../../features/ranking/ranking_screen.dart';
import '../../features/relatorios/relatorios_screen.dart';
import '../../features/trocas_beneficios/trocas_beneficios_screen.dart';

class AdminRoutes {
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String motoristas = '/motoristas';
  static const String fretes = '/fretes';
  static const String ordens = '/ordens';
  static const String comprovantes = '/comprovantes';
  static const String pontos = '/pontos';
  static const String ranking = '/ranking';
  static const String beneficios = '/beneficios';
  static const String trocasBeneficios = '/trocas-beneficios';
  static const String relatorios = '/relatorios';
  static const String avisos = '/avisos';
  static const String chamados = '/chamados';
  static const String configuracoes = '/configuracoes';

  static Map<String, WidgetBuilder> get routes {
    return {
      login: (_) => const AdminLoginScreen(),
      dashboard: (_) => const DashboardScreen(),
      motoristas: (_) => const MotoristasScreen(),
      fretes: (_) => const FretesScreen(),
      ordens: (_) => const OrdensScreen(),
      comprovantes: (_) => const ComprovantesScreen(),
      pontos: (_) => const PontosScreen(),
      ranking: (_) => const RankingScreen(),
      beneficios: (_) => const BeneficiosScreen(),
      trocasBeneficios: (_) => const TrocasBeneficiosScreen(),
      relatorios: (_) => const RelatoriosScreen(),
      avisos: (_) => const AvisosScreen(),
      chamados: (_) => const ChamadosScreen(),
      configuracoes: (_) => const ConfiguracoesScreen(),
    };
  }
}
