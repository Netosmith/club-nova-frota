import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/providers/auth_provider.dart';
import 'core/providers/fretes_provider.dart';
import 'core/providers/motorista_provider.dart';
import 'core/providers/ordens_provider.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/login_screen.dart';

class ClubNovaFrotaApp extends StatelessWidget {
  const ClubNovaFrotaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()..iniciar()),
        ChangeNotifierProvider(create: (_) => MotoristaProvider()),
        ChangeNotifierProvider(create: (_) => FretesProvider()),
        ChangeNotifierProvider(create: (_) => OrdensProvider()),
      ],
      child: MaterialApp(
        title: 'Club Nova Frota',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        routes: AppRoutes.routes,
        home: const LoginScreen(),
      ),
    );
  }
}
