import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/admin_auth_provider.dart';
import '../../core/routes/admin_routes.dart';
import '../../core/theme/admin_colors.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  Future<void> _entrar() async {
    if (!_formKey.currentState!.validate()) return;

    final sucesso = await context.read<AdminAuthProvider>().entrar(
          email: _emailController.text.trim(),
          senha: _senhaController.text.trim(),
        );

    if (!mounted) return;

    if (sucesso) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AdminRoutes.dashboard,
        (route) => false,
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Acesso não autorizado.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AdminAuthProvider>();

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 420,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(
                      Icons.admin_panel_settings,
                      size: 54,
                      color: AdminColors.azulPrincipal,
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Club Nova Frota',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Painel Administrativo',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AdminColors.cinzaTexto),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Informe o e-mail';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _senhaController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Informe a senha';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: authProvider.carregando ? null : _entrar,
                      icon: const Icon(Icons.login),
                      label: Text(
                        authProvider.carregando ? 'Entrando...' : 'Entrar',
                      ),
                    ),
                    if (authProvider.erro != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        authProvider.erro!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
