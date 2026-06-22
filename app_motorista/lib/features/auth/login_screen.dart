import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Text(
                'Portal Frete',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.azulPrincipal,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Club Nova Frota',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textoPrincipal,
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'A comunidade do motorista',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.cinzaTexto),
              ),
              const SizedBox(height: 40),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.main),
                child: const Text('Entrar'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.main),
                child: const Text('Entrar com Google'),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
