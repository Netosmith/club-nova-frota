import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/admin_comprovantes_provider.dart';
import '../../core/providers/admin_fretes_provider.dart';
import '../../core/providers/admin_motoristas_provider.dart';
import '../../core/providers/admin_ordens_provider.dart';
import '../../core/theme/admin_colors.dart';
import '../../shared/widgets/admin_layout.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _iniciado = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_iniciado) {
      context.read<AdminMotoristasProvider>().acompanharMotoristas();
      context.read<AdminFretesProvider>().acompanharFretes();
      context.read<AdminOrdensProvider>().acompanharOrdens();
      context.read<AdminComprovantesProvider>().acompanharComprovantes();
      _iniciado = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final motoristasProvider = context.watch<AdminMotoristasProvider>();
    final fretesProvider = context.watch<AdminFretesProvider>();
    final ordensProvider = context.watch<AdminOrdensProvider>();
    final comprovantesProvider = context.watch<AdminComprovantesProvider>();

    final motoristasAtivos = motoristasProvider.motoristas
        .where((motorista) => motorista.ativo)
        .length;
    final fretesDisponiveis = fretesProvider.fretes
        .where((frete) => frete.status == 'disponivel')
        .length;
    final ordensPendentes = ordensProvider.ordens
        .where((ordem) => ordem.status == 'solicitada')
        .length;
    final comprovantesPendentes = comprovantesProvider.comprovantes
        .where((comprovante) => comprovante.status == 'enviado')
        .length;

    return AdminLayout(
      title: 'Dashboard',
      child: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _DashboardCard(
            titulo: 'Motoristas cadastrados',
            valor: '${motoristasProvider.motoristas.length}',
            icone: Icons.people,
          ),
          _DashboardCard(
            titulo: 'Motoristas ativos',
            valor: '$motoristasAtivos',
            icone: Icons.verified_user,
          ),
          _DashboardCard(
            titulo: 'Fretes disponíveis',
            valor: '$fretesDisponiveis',
            icone: Icons.local_shipping,
          ),
          _DashboardCard(
            titulo: 'Ordens pendentes',
            valor: '$ordensPendentes',
            icone: Icons.assignment,
          ),
          _DashboardCard(
            titulo: 'Comprovantes pendentes',
            valor: '$comprovantesPendentes',
            icone: Icons.upload_file,
          ),
          _DashboardCard(
            titulo: 'Total de ordens',
            valor: '${ordensProvider.ordens.length}',
            icone: Icons.list_alt,
          ),
        ],
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  const _DashboardCard({
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
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icone, color: AdminColors.verdePrincipal, size: 36),
            const SizedBox(height: 14),
            Text(
              valor,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: AdminColors.textoPrincipal,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              titulo,
              style: const TextStyle(color: AdminColors.cinzaTexto),
            ),
          ],
        ),
      ),
    );
  }
}
