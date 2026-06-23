import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/auth_provider.dart';
import '../../core/providers/motorista_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/models/motorista_model.dart';
import '../../shared/utils/formatters.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  bool _iniciado = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_iniciado) {
      final usuario = context.read<AuthProvider>().usuario;
      if (usuario != null) {
        context.read<MotoristaProvider>().carregarMotorista(usuario.uid);
      }
      _iniciado = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final motoristaProvider = context.watch<MotoristaProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Meu Perfil')),
      body: _PerfilBody(provider: motoristaProvider),
    );
  }
}

class _PerfilBody extends StatelessWidget {
  const _PerfilBody({required this.provider});

  final MotoristaProvider provider;

  @override
  Widget build(BuildContext context) {
    if (provider.carregando) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.erro != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            provider.erro!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.cinzaTexto),
          ),
        ),
      );
    }

    final motorista = provider.motorista;

    if (motorista == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Perfil de motorista ainda não cadastrado.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.cinzaTexto),
          ),
        ),
      );
    }

    return _PerfilContent(motorista: motorista);
  }
}

class _PerfilContent extends StatelessWidget {
  const _PerfilContent({required this.motorista});

  final MotoristaModel motorista;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 34,
                  backgroundColor: AppColors.azulPrincipal,
                  child: Icon(Icons.person, color: AppColors.branco, size: 34),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        motorista.nome,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Medalha: ${motorista.medalha}',
                        style: const TextStyle(color: AppColors.cinzaTexto),
                      ),
                      Text(
                        Formatters.pontos(motorista.pontos),
                        style: const TextStyle(color: AppColors.verdePrincipal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            leading: const Icon(Icons.local_shipping, color: AppColors.azulPrincipal),
            title: const Text('Veículo'),
            subtitle: Text('${motorista.placa} - ${motorista.categoria}'),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.location_on, color: AppColors.azulPrincipal),
            title: const Text('Base'),
            subtitle: Text('${motorista.cidade} - ${motorista.uf}'),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.phone, color: AppColors.azulPrincipal),
            title: const Text('Contato'),
            subtitle: Text(motorista.telefone),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.history, color: AppColors.azulPrincipal),
            title: const Text('Histórico'),
            subtitle: const Text('Viagens e ordens finalizadas.'),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.settings, color: AppColors.azulPrincipal),
            title: const Text('Configurações'),
            subtitle: const Text('Senha, notificações e dados da conta.'),
          ),
        ),
      ],
    );
  }
}
