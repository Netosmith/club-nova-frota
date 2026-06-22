import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/auth_provider.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  Future<void> _entrarComEmailSenha() async {
    final authProvider = context.read<AuthProvider>();

    final sucesso = await authProvider.entrarComEmailSenha(
      email: _emailController.text.trim(),
      senha: _senhaController.text.trim(),
    );

    if (!mounted) return;

    if (sucesso) {
      Navigator.pushReplacementNamed(context, AppRoutes.main);
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(authProvider.erro ?? 'Não foi possível entrar.')),
    );
  }

  Future<void> _entrarComGoogle() async {
    final authProvider = context.read<AuthProvider>();

    final sucesso = await authProvider.entrarComGoogle();

    if (!mounted) return;

    if (sucesso) {
      Navigator.pushReplacementNamed(context, AppRoutes.main);
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(authProvider.erro ?? 'Não foi possível entrar com Google.')),
    );
  }

  Future<void> _recuperarSenha() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe seu e-mail para recuperar a senha.')),
      );
      return;
    }

    await context.read<AuthProvider>().recuperarSenha(email);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('E-mail de recuperação enviado.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final carregando = context.watch<AuthProvider>().carregando;

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
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _senhaController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: carregando ? null : _recuperarSenha,
                  child: const Text('Esqueci minha senha'),
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: carregando ? null : _entrarComEmailSenha,
                child: Text(carregando ? 'Entrando...' : 'Entrar'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: carregando ? null : _entrarComGoogle,
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
