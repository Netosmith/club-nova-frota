import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/admin_pedidos_beneficios_provider.dart';
import '../../core/theme/admin_colors.dart';
import '../../shared/models/pedido_beneficio_admin_model.dart';
import '../../shared/widgets/admin_layout.dart';

class PedidosBeneficiosScreen extends StatefulWidget {
  const PedidosBeneficiosScreen({super.key});

  @override
  State<PedidosBeneficiosScreen> createState() => _PedidosBeneficiosScreenState();
}

class _PedidosBeneficiosScreenState extends State<PedidosBeneficiosScreen> {
  bool _iniciado = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_iniciado) {
      context.read<AdminPedidosBeneficiosProvider>().acompanharPedidos();
      _iniciado = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AdminPedidosBeneficiosProvider>();

    return AdminLayout(
      title: 'Pedidos de Benefícios',
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Pedidos de troca de pontos por benefícios',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AdminColors.textoPrincipal,
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 2.8,
              children: [
                _ResumoPedidoCard(
                  titulo: 'Novos pedidos',
                  valor: '${provider.novos}',
                  icone: Icons.inbox,
                ),
                _ResumoPedidoCard(
                  titulo: 'Aprovados',
                  valor: '${provider.aprovados}',
                  icone: Icons.check_circle,
                ),
                _ResumoPedidoCard(
                  titulo: 'Entregues',
                  valor: '${provider.entregues}',
                  icone: Icons.card_giftcard,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(child: _PedidosContent(provider: provider)),
          ],
        ),
      ),
    );
  }
}

class _ResumoPedidoCard extends StatelessWidget {
  const _ResumoPedidoCard({
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
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Icon(icone, color: AdminColors.verdePrincipal, size: 34),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    valor,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    titulo,
                    style: const TextStyle(color: AdminColors.cinzaTexto),
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

class _PedidosContent extends StatelessWidget {
  const _PedidosContent({required this.provider});

  final AdminPedidosBeneficiosProvider provider;

  @override
  Widget build(BuildContext context) {
    if (provider.carregando) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.erro != null) {
      return Center(
        child: Text(
          provider.erro!,
          style: const TextStyle(color: AdminColors.cinzaTexto),
        ),
      );
    }

    if (provider.pedidos.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum pedido encontrado.',
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
          rows: provider.pedidos.map((pedido) {
            return _pedidoRow(context, pedido);
          }).toList(),
        ),
      ),
    );
  }

  DataRow _pedidoRow(BuildContext context, PedidoBeneficioAdminModel pedido) {
    final provider = context.read<AdminPedidosBeneficiosProvider>();

    return DataRow(
      cells: [
        DataCell(Text(pedido.nomeMotorista)),
        DataCell(Text(pedido.tituloBeneficio)),
        DataCell(Text('${pedido.pontosUsados}')),
        DataCell(
          Chip(
            label: Text(pedido.situacao),
            backgroundColor: _situacaoColor(pedido.situacao),
          ),
        ),
        DataCell(Text(pedido.observacoes.isEmpty ? '-' : pedido.observacoes)),
        DataCell(
          Row(
            children: [
              IconButton(
                tooltip: 'Aprovar',
                onPressed: () => provider.atualizarSituacao(
                  pedidoId: pedido.id,
                  situacao: 'aprovado',
                ),
                icon: const Icon(Icons.check_circle),
              ),
              IconButton(
                tooltip: 'Recusar',
                onPressed: () => provider.atualizarSituacao(
                  pedidoId: pedido.id,
                  situacao: 'recusado',
                ),
                icon: const Icon(Icons.cancel),
              ),
              IconButton(
                tooltip: 'Entregue',
                onPressed: () => provider.atualizarSituacao(
                  pedidoId: pedido.id,
                  situacao: 'entregue',
                ),
                icon: const Icon(Icons.card_giftcard),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _situacaoColor(String situacao) {
    switch (situacao) {
      case 'aprovado':
        return AdminColors.verdePrincipal.withValues(alpha: 0.12);
      case 'recusado':
        return Colors.red.withValues(alpha: 0.12);
      case 'entregue':
        return Colors.blue.withValues(alpha: 0.12);
      default:
        return Colors.orange.withValues(alpha: 0.12);
    }
  }
}
