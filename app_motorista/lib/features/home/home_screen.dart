import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Club Nova Frota'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text(
            'Olá, motorista!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppColors.textoPrincipal,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Bem-vindo ao seu painel operacional.',
            style: TextStyle(color: AppColors.cinzaTexto),
          ),
          SizedBox(height: 20),
          _ResumoCard(
            titulo: 'Pontos disponíveis',
            valor: '0 pontos',
            icone: Icons.stars,
          ),
          _ResumoCard(
            titulo: 'Fretes disponíveis',
            valor: 'Ver cargas liberadas',
            icone: Icons.local_shipping,
          ),
          _ResumoCard(
            titulo: 'Minhas ordens',
            valor: 'Acompanhar viagens',
            icone: Icons.assignment,
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
