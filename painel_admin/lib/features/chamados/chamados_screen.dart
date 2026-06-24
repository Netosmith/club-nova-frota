import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/admin_auth_provider.dart';
import '../../core/providers/admin_chamados_provider.dart';
import '../../core/theme/admin_colors.dart';
import '../../shared/models/chamado_admin_model.dart';
import '../../shared/widgets/admin_layout.dart';

class ChamadosScreen extends StatefulWidget {
  const ChamadosScreen({super.key});

  @override
  State<ChamadosScreen> createState() => _ChamadosScreenState();
}

class _ChamadosScreenState extends State<ChamadosScreen> {
  bool _iniciado = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_iniciado) {
      context.read<AdminChamadosProvider>().acompanharChamados();
      _iniciado = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AdminChamadosProvider>();

    return AdminLayout(
      title: 'Chamados',
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Atendimento e suporte aos motoristas',
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
                _ResumoChamadoCard(
                  titulo: 'Abertos',
                  valor: '${provider.abertos}',
                  icone: Icons.support_agent,
                ),
                _ResumoChamadoCard(
                  titulo: 'Em atendimento',
                  valor: '${provider.emAtendimento}',
                  icone: Icons.pending_actions,
                ),
                _ResumoChamadoCard(
                  titulo: 'Finalizados',
                  valor: '${provider.finalizados}',
                  icone: Icons.check_circle,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(child: _ChamadosContent(provider: provider)),
          ],
        ),
      ),
    );
  }
}

class _ResumoChamadoCard extends StatelessWidget {
  const _ResumoChamadoCard({
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

class _ChamadosContent extends StatelessWidget {
  const _ChamadosContent({required this.provider});

  final AdminChamadosProvider provider;

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

    if (provider.chamados.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum chamado encontrado.',
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
            DataColumn(label: Text('Telefone')),
            DataColumn(label: Text('Assunto')),
            DataColumn(label: Text('Prioridade')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Responsável')),
            DataColumn(label: Text('Ações')),
          ],
          rows: provider.chamados.map((chamado) {
            return _chamadoRow(context, chamado);
          }).toList(),
        ),
      ),
    );
  }

  DataRow _chamadoRow(BuildContext context, ChamadoAdminModel chamado) {
    final usuario = context.read<AdminAuthProvider>().usuario;
    final responsavel = usuario?.email ?? 'admin';
    final chamadosProvider = context.read<AdminChamadosProvider>();

    return DataRow(
      cells: [
        DataCell(Text(chamado.nomeMotorista)),
        DataCell(Text(chamado.telefone)),
        DataCell(Text(chamado.assunto)),
        DataCell(Chip(label: Text(chamado.prioridade))),
        DataCell(Chip(label: Text(chamado.status))),
        DataCell(Text(chamado.responsavel.isEmpty ? '-' : chamado.responsavel)),
        DataCell(
          Row(
            children: [
              IconButton(
                tooltip: 'Assumir atendimento',
                onPressed: () => chamadosProvider.atualizarStatus(
                  chamadoId: chamado.id,
                  status: 'em_atendimento',
                  responsavel: responsavel,
                ),
                icon: const Icon(Icons.support_agent),
              ),
              IconButton(
                tooltip: 'Finalizar',
                onPressed: () => chamadosProvider.atualizarStatus(
                  chamadoId: chamado.id,
                  status: 'finalizado',
                  responsavel: responsavel,
                ),
                icon: const Icon(Icons.check_circle),
              ),
              IconButton(
                tooltip: 'Reabrir',
                onPressed: () => chamadosProvider.atualizarStatus(
                  chamadoId: chamado.id,
                  status: 'aberto',
                  responsavel: responsavel,
                ),
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
