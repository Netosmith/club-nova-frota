import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/providers/admin_auth_provider.dart';
import 'core/providers/admin_comprovantes_provider.dart';
import 'core/providers/admin_fretes_provider.dart';
import 'core/providers/admin_motoristas_provider.dart';
import 'core/providers/admin_ordens_provider.dart';
import 'core/providers/admin_pontos_provider.dart';
import 'core/providers/admin_ranking_provider.dart';
import 'core/providers/admin_usuarios_provider.dart';
import 'core/routes/admin_routes.dart';
import 'core/theme/admin_theme.dart';

class PainelAdminApp extends StatelessWidget {
  const PainelAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AdminAuthProvider()..iniciar()),
        ChangeNotifierProvider(create: (_) => AdminMotoristasProvider()),
        ChangeNotifierProvider(create: (_) => AdminFretesProvider()),
        ChangeNotifierProvider(create: (_) => AdminOrdensProvider()),
        ChangeNotifierProvider(create: (_) => AdminComprovantesProvider()),
        ChangeNotifierProvider(create: (_) => AdminPontosProvider()),
        ChangeNotifierProvider(create: (_) => AdminRankingProvider()),
        ChangeNotifierProvider(create: (_) => AdminUsuariosProvider()),
      ],
      child: MaterialApp(
        title: 'Painel Admin - Club Nova Frota',
        debugShowCheckedModeBanner: false,
        theme: AdminTheme.light,
        routes: AdminRoutes.routes,
        initialRoute: AdminRoutes.login,
      ),
    );
  }
}
