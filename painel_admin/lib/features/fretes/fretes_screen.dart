import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/admin_fretes_provider.dart';
import '../../core/theme/admin_colors.dart';
import '../../shared/models/frete_admin_model.dart';
import '../../shared/widgets/admin_layout.dart';

class FretesScreen extends StatefulWidget {
  const FretesScreen({super.key});

  @override
  State<FretesScreen> createState() => _FretesScreenState();
}

class _FretesScreenState extends State<FretesScreen> {
  bool _iniciado = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_iniciado) {
      context.read<AdminFretesProvider>().acompanharFretes();
      _iniciado = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AdminFretesProvider>();

    return AdminLayout(
      title: 'Fretes',
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Cadastro e gestão de fretes',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AdminColors.textoPrincipal,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('Novo Frete'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(child: _FretesContent(provider: provider)),
          ],
        ),
      ),
    );
  }
}

class _FretesContent extends StatelessWidget {
  const _FretesContent({required this.provider});

  final AdminFretesProvider provider;

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

    if (provider.fretes.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum frete cadastrado.',
          style: TextStyle(color: AdminColors.cinzaTexto),
        ),
      );
    }

    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Cliente')),
            DataColumn(label: Text('Origem')),
            DataColumn(label: Text('Destino')),
            DataColumn(label: Text('Produto')),
            DataColumn(label: Text('Valor')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Ações')),
          ],
          rows: provider.fretes.map((frete) {
            return _freteRow(context, frete);
          }).toList(),
        ),
      ),
    );
  }

  DataRow _freteRow(BuildContext context, FreteAdminModel frete) {
    return DataRow(
      cells: [
        DataCell(Text(frete.cliente)),
        DataCell(Text(frete.origem)),
        DataCell(Text(frete.destino)),
        DataCell(Text(frete.produto)),
        DataCell(Text('R\$ ${frete.valor.toStringAsFixed(2)}/t')),
        DataCell(
          Chip(
            label: Text(frete.status),
            backgroundColor: _statusColor(frete.status),
          ),
        ),
        DataCell(
          Row(
            children: [
              IconButton(
                tooltip: 'Editar',
                onPressed: () {},
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                tooltip: 'Liberar',
                onPressed: () => context
                    .read<AdminFretesProvider>()
                    .liberarFrete(frete.id),
                icon: const Icon(Icons.check_circle),
              ),
              IconButton(
                tooltip: 'Encerrar',
                onPressed: () => context
                    .read<AdminFretesProvider>()
                    .encerrarFrete(frete.id),
                icon: const Icon(Icons.stop_circle),
              ),
              IconButton(
                tooltip: 'Cancelar',
                onPressed: () => context
                    .read<AdminFretesProvider>()
                    .cancelarFrete(frete.id),
                icon: const Icon(Icons.cancel),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'disponivel':
        return AdminColors.verdePrincipal.withValues(alpha: 0.12);
      case 'encerrado':
        return Colors.blue.withValues(alpha: 0.12);
      case 'cancelado':
        return Colors.red.withValues(alpha: 0.12);
      default:
        return Colors.orange.withValues(alpha: 0.12);
    }
  }
}
