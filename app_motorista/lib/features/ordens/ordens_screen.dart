import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class OrdensScreen extends StatelessWidget {
  const OrdensScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ordens = [
      {
        'numero': 'ORDEM-001',
        'rota': 'Rio Verde - GO → Uberlândia - MG',
        'status': 'Liberada',
      },
      {
        'numero': 'ORDEM-002',
        'rota': 'Jataí - GO → Santos - SP',
        'status': 'Solicitada',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Minhas Ordens')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: ordens.length,
        itemBuilder: (context, index) {
          final ordem = ordens[index];
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
                          ordem['numero']!,
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 4),
                        Text(ordem['rota']!),
                        const SizedBox(height: 6),
                        Text(
                          'Status: ${ordem['status']}',
                          style: const TextStyle(
                            color: AppColors.verdePrincipal,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
