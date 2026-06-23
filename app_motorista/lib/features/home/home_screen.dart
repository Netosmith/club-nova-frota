import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/auth_provider.dart';
import '../../core/providers/fretes_provider.dart';
import '../../core/providers/motorista_provider.dart';
import '../../core/providers/ordens_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/utils/formatters.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _iniciado = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_iniciado) {
      final usuario = context.read<AuthProvider>().usuario;

      context.read<FretesProvider>().acompanharFretesDisponiveis();

      if (usuario != null) {
        context.read<MotoristaProvider>().carregarMotorista(usuario.uid);
        context.read<OrdensProvider>().acompanharOrdensDoMotorista(usuario.uid);
      }

      _iniciado = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final motoristaProvider = context.watch<MotoristaProvider>();
    final fretesProvider = context.watch<FretesProvider>();
    final ordensProvider = context.watch<OrdensProvider>();

    final motorista = motoristaProvider.motorista;
    final nome = motorista?.nome.isNotEmpty == true ? motorista!.nome : 'motorista';
    final pontos = motorista?.pontos ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Club Nova Frota'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Olá, $nome!',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppColors.textoPrincipal,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Bem-vindo ao seu painel operacional.',
            style: TextStyle(color: AppColors.cinzaTexto),
          ),
          const SizedBox(height: 20),
          _ResumoCard(
            titulo: 'Pontos disponíveis',
            valor: Formatters.pontos(pontos),
            icone: Icons.stars,
          ),
          _ResumoCard(
            titulo: 'Fretes disponíveis',
            valor: fretesProvider.carregando
                ? 'Carregando...'
                : '${fretesProvider.fretes.length} cargas liberadas',
            icone: Icons.local_shipping,
          ),
          _ResumoCard(
            titulo: 'Minhas ordens',
            valor: ordensProvider.carregando
                ? 'Carregando...'
                : '${ordensProvider.ordens.length} ordens cadastradas',
            icone: Icons.assignment,
          ),
          _ResumoCard(
            titulo: 'Medalha atual',
            valor: motorista?.medalha ?? 'Sem medalha cadastrada',
            icone: Icons.emoji_events,
          ),
        ],
      ),
    );
  }
}

class _ResumoCard extends StatelessWidget {
  const _ResumoCard({
    required this.titulo,
    required this.valor,
    required this.icone,
  });

  final String titulo;
  final String valor;
  final IconData icone;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Icon(icone, color: AppColors.verdePrincipal, size: 34),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    valor,
                    style: const TextStyle(color: AppColors.cinzaTexto),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
