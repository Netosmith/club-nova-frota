import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class FretesScreen extends StatelessWidget {
  const FretesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fretes = [
      {
        'origem': 'Rio Verde - GO',
        'destino': 'Uberlândia - MG',
        'produto': 'Soja',
        'valor': 'R\$ 180/t',
      },
      {
        'origem': 'Jataí - GO',
        'destino': 'Santos - SP',
        'produto': 'Milho',
        'valor': 'R\$ 260/t',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Fretes Disponíveis')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: fretes.length,
        itemBuilder: (context, index) {
          final frete = fretes[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 14),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${frete['origem']} → ${frete['destino']}',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Produto: ${frete['produto']}'),
                  Text('Valor: ${frete['valor']}'),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Solicitar Ordem'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.verdePrincipal,
        onPressed: () {},
        child: const Icon(Icons.filter_list, color: AppColors.branco),
      ),
    );
  }
}
