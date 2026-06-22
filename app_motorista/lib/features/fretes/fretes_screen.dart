import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/auth_provider.dart';
import '../../core/providers/fretes_provider.dart';
import '../../core/providers/ordens_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/models/frete_model.dart';
import '../../shared/utils/formatters.dart';

class FretesScreen extends StatefulWidget {
  const FretesScreen({super.key});

  @override
  State<FretesScreen> createState() => _FretesScreenState();
}

class _FretesScreenState extends State<FretesScreen> {
  bool _iniciado = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_iniciado) {
      context.read<FretesProvider>().acompanharFretesDisponiveis();
      _iniciado = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FretesProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Fretes Disponíveis')),
      body: _FretesBody(provider: provider),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.verdePrincipal,
        onPressed: () {},
        child: const Icon(Icons.filter_list, color: AppColors.branco),
      ),
    );
  }
}

class _FretesBody extends StatelessWidget {
  const _FretesBody({required this.provider});

  final FretesProvider provider;

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

    if (provider.fretes.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Nenhum frete disponível no momento.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.cinzaTexto),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: provider.fretes.length,
      itemBuilder: (context, index) {
        final frete = provider.fretes[index];
        return _FreteCard(frete: frete);
      },
    );
  }
}

class _FreteCard extends StatelessWidget {
  const _FreteCard({required this.frete});

  final FreteModel frete;

  Future<void> _solicitarOrdem(BuildContext context) async {
    final usuario = context.read<AuthProvider>().usuario;

    if (usuario == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Faça login novamente para solicitar ordem.')),
      );
      return;
    }

    final sucesso = await context.read<OrdensProvider>().solicitarOrdem(
          motoristaId: usuario.uid,
          freteId: frete.id,
        );

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          sucesso
              ? 'Ordem solicitada com sucesso.'
              : 'Não foi possível solicitar a ordem.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final solicitando = context.watch<OrdensProvider>().carregando;

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Formatters.rota(frete.origem, frete.destino),
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text('Cliente: ${frete.cliente}'),
            Text('Produto: ${frete.produto}'),
            Text('Valor: ${Formatters.moedaPorTonelada(frete.valor)}'),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: solicitando ? null : () => _solicitarOrdem(context),
                child: Text(solicitando ? 'Solicitando...' : 'Solicitar Ordem'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
