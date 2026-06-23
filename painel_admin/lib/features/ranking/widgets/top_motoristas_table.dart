import 'package:flutter/material.dart';

import '../../../shared/models/ranking_admin_model.dart';
import 'medalha_widget.dart';

class TopMotoristasTable extends StatelessWidget {
  const TopMotoristasTable({
    super.key,
    required this.ranking,
  });

  final List<RankingAdminModel> ranking;

  @override
  Widget build(BuildContext context) {
    final topRanking = ranking.take(10).toList();

    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('#')),
            DataColumn(label: Text('Motorista')),
            DataColumn(label: Text('Pontos')),
            DataColumn(label: Text('Viagens')),
            DataColumn(label: Text('Comprovantes')),
            DataColumn(label: Text('Indicações')),
            DataColumn(label: Text('Medalha')),
          ],
          rows: topRanking.asMap().entries.map((entry) {
            final posicao = entry.key + 1;
            final item = entry.value;

            return DataRow(
              cells: [
                DataCell(Text('$posicaoº')),
                DataCell(Text(item.nomeMotorista)),
                DataCell(Text('${item.pontos}')),
                DataCell(Text('${item.viagens}')),
                DataCell(Text('${item.comprovantes}')),
                DataCell(Text('${item.indicacoes}')),
                DataCell(MedalhaWidget(medalha: item.medalha)),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
