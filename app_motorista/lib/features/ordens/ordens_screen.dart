import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/auth_provider.dart';
import '../../core/providers/ordens_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/models/ordem_model.dart';

class OrdensScreen extends StatefulWidget {
  const OrdensScreen({super.key});

  @override
  State<OrdensScreen> createState() => _OrdensScreenState();
}

class _OrdensScreenState extends State<OrdensScreen> {
  bool _iniciado = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_iniciado) {
      final usuario = context.read<AuthProvider>().usuario;
      if (usuario != null) {
        context.read<OrdensProvider>().acompanharOrdensDoMotorista(usuario.uid);
      }
      _iniciado = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OrdensProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Minhas Ordens')),
      body: _OrdensBody(provider: provider),
    );
  }
}

class _OrdensBody extends StatelessWidget {
  const _OrdensBody({required this.provider});

  final OrdensProvider provider;

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

    if (provider.ordens.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Nenhuma ordem encontrada.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.cinzaTexto),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: provider.ordens.length,
      itemBuilder: (context, index) {
        final ordem = provider.ordens[index];
        return _OrdemCard(ordem: ordem);
      },
    );
  }
}

class _OrdemCard extends StatelessWidget {
  const _OrdemCard({required this.ordem});

  final OrdemModel ordem;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.assignment, color: AppColors.azulPrincipal),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ordem ${ordem.id}',
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 4),
                  Text('Frete: ${ordem.freteId}'),
                  const SizedBox(height: 6),
                  Text(
                    'Status: ${ordem.status}',
                    style: const TextStyle(
                      color: AppColors.verdePrincipal,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (ordem.observacoes.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text('Obs.: ${ordem.observacoes}'),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
