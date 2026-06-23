import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/admin_comprovantes_provider.dart';
import '../../core/theme/admin_colors.dart';
import '../../shared/models/comprovante_admin_model.dart';
import '../../shared/widgets/admin_layout.dart';

class ComprovantesScreen extends StatefulWidget {
  const ComprovantesScreen({super.key});

  @override
  State<ComprovantesScreen> createState() => _ComprovantesScreenState();
}

class _ComprovantesScreenState extends State<ComprovantesScreen> {
  bool _iniciado = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_iniciado) {
      context.read<AdminComprovantesProvider>().acompanharComprovantes();
      _iniciado = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AdminComprovantesProvider>();

    return AdminLayout(
      title: 'Comprovantes',
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Análise e aprovação de comprovantes',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AdminColors.textoPrincipal,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(child: _ComprovantesContent(provider: provider)),
          ],
        ),
      ),
    );
  }
}

class _ComprovantesContent extends StatelessWidget {
  const _ComprovantesContent({required this.provider});

  final AdminComprovantesProvider provider;

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

    if (provider.comprovantes.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum comprovante encontrado.',
          style: TextStyle(color: AdminColors.cinzaTexto),
        ),
      );
    }

    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Comprovante')),
            DataColumn(label: Text('Ordem')),
            DataColumn(label: Text('Motorista')),
            DataColumn(label: Text('Tipo')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Observações')),
            DataColumn(label: Text('Ações')),
          ],
          rows: provider.comprovantes.map((comprovante) {
            return _comprovanteRow(context, comprovante);
          }).toList(),
        ),
      ),
    );
  }

  DataRow _comprovanteRow(
    BuildContext context,
    ComprovanteAdminModel comprovante,
  ) {
    const usuarioAdminTemporario = 'admin';

    return DataRow(
      cells: [
        DataCell(Text(comprovante.id)),
        DataCell(Text(comprovante.ordemId)),
        DataCell(Text(comprovante.motoristaId)),
        DataCell(Text(comprovante.tipoArquivo.isEmpty ? '-' : comprovante.tipoArquivo)),
        DataCell(
          Chip(
            label: Text(comprovante.status),
            backgroundColor: _statusColor(comprovante.status),
          ),
        ),
        DataCell(Text(comprovante.observacoes.isEmpty ? '-' : comprovante.observacoes)),
        DataCell(
          Row(
            children: [
              IconButton(
                tooltip: 'Visualizar arquivo',
                onPressed: comprovante.arquivoUrl.isEmpty ? null : () {},
                icon: const Icon(Icons.visibility),
              ),
              IconButton(
                tooltip: 'Aprovar comprovante',
                onPressed: () => context
                    .read<AdminComprovantesProvider>()
                    .aprovarComprovante(
                      comprovanteId: comprovante.id,
                      analisadoPor: usuarioAdminTemporario,
                    ),
                icon: const Icon(Icons.check_circle),
              ),
              IconButton(
                tooltip: 'Rejeitar comprovante',
                onPressed: () => context
                    .read<AdminComprovantesProvider>()
                    .rejeitarComprovante(
                      comprovanteId: comprovante.id,
                      analisadoPor: usuarioAdminTemporario,
                    ),
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
      case 'aprovado':
        return AdminColors.verdePrincipal.withValues(alpha: 0.12);
      case 'rejeitado':
        return Colors.red.withValues(alpha: 0.12);
      case 'reenviar':
        return Colors.orange.withValues(alpha: 0.12);
      default:
        return Colors.blue.withValues(alpha: 0.12);
    }
  }
}
