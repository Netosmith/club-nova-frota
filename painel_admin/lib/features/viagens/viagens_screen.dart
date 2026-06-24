import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/admin_viagens_provider.dart';
import '../../core/theme/admin_colors.dart';
import '../../shared/widgets/admin_layout.dart';

class ViagensScreen extends StatelessWidget {
  const ViagensScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AdminViagensProvider()..acompanharViagens(),
      child: const _ViagensView(),
    );
  }
}

class _ViagensView extends StatelessWidget {
  const _ViagensView();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AdminViagensProvider>();

    return AdminLayout(
      title: 'Viagens',
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Gestão operacional das viagens',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AdminColors.textoPrincipal,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Card(
                child: provider.carregando
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('Motorista')),
                            DataColumn(label: Text('Origem')),
                            DataColumn(label: Text('Destino')),
                            DataColumn(label: Text('Ordem')),
                            DataColumn(label: Text('Status')),
                            DataColumn(label: Text('Previsao')),
                          ],
                          rows: provider.viagens.map((viagem) {
                            return DataRow(
                              cells: [
                                DataCell(Text(viagem.nomeMotorista)),
                                DataCell(Text(viagem.origem)),
                                DataCell(Text(viagem.destino)),
                                DataCell(Text(viagem.ordemId)),
                                DataCell(Chip(label: Text(viagem.status))),
                                DataCell(Text(viagem.previsaoEntrega.isEmpty ? '-' : viagem.previsaoEntrega)),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
