import 'package:flutter/material.dart';

import '../../core/theme/admin_colors.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Painel Admin - Club Nova Frota')),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: const [
          _DashboardCard(titulo: 'Motoristas', valor: '0', icone: Icons.people),
          _DashboardCard(titulo: 'Fretes', valor: '0', icone: Icons.local_shipping),
          _DashboardCard(titulo: 'Ordens', valor: '0', icone: Icons.assignment),
          _DashboardCard(titulo: 'Comprovantes', valor: '0', icone: Icons.upload_file),
          _DashboardCard(titulo: 'Pontos', valor: '0', icone: Icons.stars),
          _DashboardCard(titulo: 'Ranking', valor: '0', icone: Icons.emoji_events),
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
