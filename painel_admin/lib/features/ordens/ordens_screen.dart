import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/admin_ordens_provider.dart';
import '../../core/theme/admin_colors.dart';
import '../../shared/models/ordem_admin_model.dart';
import '../../shared/widgets/admin_layout.dart';

class OrdensScreen extends StatefulWidget {
  const OrdensScreen({super.key});

  @override
  State<OrdensScreen> createState() => _OrdensScreenState();
}

class _OrdensScreenState extends State<OrdensScreen> {
  bool _iniciado = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_iniciado) {
      context.read<AdminOrdensProvider>().acompanharOrdens();
      _iniciado = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AdminOrdensProvider>();

    return AdminLayout(
      title: 'Ordens',
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Gestão de solicitações e ordens',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AdminColors.textoPrincipal,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(child: _OrdensContent(provider: provider)),
          ],
        ),
      ),
    );
  }
}

class _OrdensContent extends StatelessWidget {
  const _OrdensContent({required this.provider});

  final AdminOrdensProvider provider;

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

    if (provider.ordens.isEmpty) {
      return const Center(
        child: Text(
          'Nenhuma ordem encontrada.',
          style: TextStyle(color: AdminColors.cinzaTexto),
        ),
      );
    }

    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Ordem')),
            DataColumn(label: Text('Motorista')),
            DataColumn(label: Text('Frete')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Comprovante')),
            DataColumn(label: Text('Observações')),
            DataColumn(label: Text('Ações')),
          ],
          rows: provider.ordens.map((ordem) {
            return _ordemRow(context, ordem);
          }).toList(),
        ),
      ),
    );
  }

  DataRow _ordemRow(BuildContext context, OrdemAdminModel ordem) {
    return DataRow(
      cells: [
        DataCell(Text(ordem.id)),
        DataCell(Text(ordem.motoristaId)),
        DataCell(Text(ordem.freteId)),
        DataCell(
          Chip(
            label: Text(ordem.status),
            backgroundColor: _statusColor(ordem.status),
          ),
        ),
        DataCell(
          Icon(
            ordem.comprovanteUrl.isEmpty ? Icons.close : Icons.check_circle,
            color: ordem.comprovanteUrl.isEmpty ? Colors.red : AdminColors.verdePrincipal,
          ),
        ),
        DataCell(Text(ordem.observacoes.isEmpty ? '-' : ordem.observacoes)),
        DataCell(
          Row(
            children: [
              IconButton(
                tooltip: 'Aprovar',
                onPressed: () => context
                    .read<AdminOrdensProvider>()
                    .aprovarOrdem(ordem.id),
                icon: const Icon(Icons.check_circle),
              ),
              IconButton(
                tooltip: 'Rejeitar',
                onPressed: () => context
                    .read<AdminOrdensProvider>()
                    .rejeitarOrdem(ordem.id),
                icon: const Icon(Icons.cancel),
              ),
              IconButton(
                tooltip: 'Em viagem',
                onPressed: () => context
                    .read<AdminOrdensProvider>()
                    .atualizarStatus(ordemId: ordem.id, status: 'em_viagem'),
                icon: const Icon(Icons.local_shipping),
              ),
              IconButton(
                tooltip: 'Finalizar',
                onPressed: () => context
                    .read<AdminOrdensProvider>()
                    .atualizarStatus(ordemId: ordem.id, status: 'finalizada'),
                icon: const Icon(Icons.flag),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'liberada':
        return AdminColors.verdePrincipal.withValues(alpha: 0.12);
      case 'negada':
      case 'cancelada':
        return Colors.red.withValues(alpha: 0.12);
      case 'em_viagem':
        return Colors.blue.withValues(alpha: 0.12);
      case 'finalizada':
        return Colors.purple.withValues(alpha: 0.12);
      default:
        return Colors.orange.withValues(alpha: 0.12);
    }
  }
}
