import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/admin_motoristas_provider.dart';
import '../../core/theme/admin_colors.dart';
import '../../shared/models/motorista_admin_model.dart';
import '../../shared/widgets/admin_layout.dart';

class MotoristasScreen extends StatefulWidget {
  const MotoristasScreen({super.key});

  @override
  State<MotoristasScreen> createState() => _MotoristasScreenState();
}

class _MotoristasScreenState extends State<MotoristasScreen> {
  bool _iniciado = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_iniciado) {
      context.read<AdminMotoristasProvider>().acompanharMotoristas();
      _iniciado = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AdminMotoristasProvider>();

    return AdminLayout(
      title: 'Motoristas',
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Cadastro e gestão de motoristas',
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
                  label: const Text('Novo Motorista'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(child: _MotoristasContent(provider: provider)),
          ],
        ),
      ),
    );
  }
}

class _MotoristasContent extends StatelessWidget {
  const _MotoristasContent({required this.provider});

  final AdminMotoristasProvider provider;

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

    if (provider.motoristas.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum motorista cadastrado.',
          style: TextStyle(color: AdminColors.cinzaTexto),
        ),
      );
    }

    return Card(
      child: SingleChildScrollView(
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Nome')),
            DataColumn(label: Text('Telefone')),
            DataColumn(label: Text('Cidade/UF')),
            DataColumn(label: Text('Placa')),
            DataColumn(label: Text('Pontos')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Ações')),
          ],
          rows: provider.motoristas.map((motorista) {
            return _motoristaRow(context, motorista);
          }).toList(),
        ),
      ),
    );
  }

  DataRow _motoristaRow(BuildContext context, MotoristaAdminModel motorista) {
    return DataRow(
      cells: [
        DataCell(Text(motorista.nome)),
        DataCell(Text(motorista.telefone)),
        DataCell(Text('${motorista.cidade}/${motorista.uf}')),
        DataCell(Text(motorista.placa)),
        DataCell(Text('${motorista.pontos}')),
        DataCell(
          Chip(
            label: Text(motorista.ativo ? 'Ativo' : 'Bloqueado'),
            backgroundColor: motorista.ativo
                ? AdminColors.verdePrincipal.withValues(alpha: 0.12)
                : Colors.red.withValues(alpha: 0.12),
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
                tooltip: motorista.ativo ? 'Bloquear' : 'Ativar',
                onPressed: () {
                  final adminProvider = context.read<AdminMotoristasProvider>();
                  if (motorista.ativo) {
                    adminProvider.bloquearMotorista(motorista.id);
                  } else {
                    adminProvider.ativarMotorista(motorista.id);
                  }
                },
                icon: Icon(motorista.ativo ? Icons.block : Icons.check_circle),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
