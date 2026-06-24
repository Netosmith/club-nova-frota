import 'package:flutter/material.dart';

import '../../core/services/admin_pedidos_beneficios_service.dart';
import '../../core/theme/admin_colors.dart';
import '../../shared/models/pedido_beneficio_admin_model.dart';
import '../../shared/widgets/admin_layout.dart';

class TrocasBeneficiosScreen extends StatelessWidget {
  const TrocasBeneficiosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = AdminPedidosBeneficiosService();

    return AdminLayout(
      title: 'Trocas de Benefícios',
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Trocas de pontos por benefícios',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AdminColors.textoPrincipal,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<List<PedidoBeneficioAdminModel>>(
                stream: service.listarPedidos(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final itens = snapshot.data ?? [];

                  if (itens.isEmpty) {
                    return const Center(
                      child: Text(
                        'Nenhuma troca encontrada.',
                        style: TextStyle(color: AdminColors.cinzaTexto),
                      ),
                    );
                  }

                  return Card(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Motorista')),
                          DataColumn(label: Text('Benefício')),
                          DataColumn(label: Text('Pontos')),
                          DataColumn(label: Text('Situação')),
                          DataColumn(label: Text('Observações')),
                          DataColumn(label: Text('Ações')),
                        ],
                        rows: itens.map((item) {
                          return DataRow(
                            cells: [
                              DataCell(Text(item.nomeMotorista)),
                              DataCell(Text(item.tituloBeneficio)),
                              DataCell(Text('${item.pontosUsados}')),
                              DataCell(Chip(label: Text(item.situacao))),
                              DataCell(Text(item.observacoes.isEmpty ? '-' : item.observacoes)),
                              DataCell(
                                Row(
                                  children: [
                                    IconButton(
                                      tooltip: 'Aprovar',
                                      onPressed: () => service.atualizarSituacao(
                                        pedidoId: item.id,
                                        situacao: 'aprovado',
                                      ),
                                      icon: const Icon(Icons.check_circle),
                                    ),
                                    IconButton(
                                      tooltip: 'Recusar',
                                      onPressed: () => service.atualizarSituacao(
                                        pedidoId: item.id,
                                        situacao: 'recusado',
                                      ),
                                      icon: const Icon(Icons.cancel),
                                    ),
                                    IconButton(
                                      tooltip: 'Entregue',
                                      onPressed: () => service.atualizarSituacao(
                                        pedidoId: item.id,
                                        situacao: 'entregue',
                                      ),
                                      icon: const Icon(Icons.card_giftcard),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
