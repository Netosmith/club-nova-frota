import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/admin_auth_provider.dart';
import '../../core/providers/admin_notificacoes_provider.dart';
import '../../core/theme/admin_colors.dart';
import '../../shared/models/notificacao_admin_model.dart';
import '../../shared/widgets/admin_layout.dart';

class NotificacoesScreen extends StatefulWidget {
  const NotificacoesScreen({super.key});

  @override
  State<NotificacoesScreen> createState() => _NotificacoesScreenState();
}

class _NotificacoesScreenState extends State<NotificacoesScreen> {
  bool _iniciado = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_iniciado) {
      context.read<AdminNotificacoesProvider>().acompanharNotificacoes();
      _iniciado = true;
    }
  }

  Future<void> _novaNotificacao() async {
    await showDialog<void>(
      context: context,
      builder: (_) => const _NotificacaoDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AdminNotificacoesProvider>();

    return AdminLayout(
      title: 'Notificações',
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Comunicados e notificações para motoristas',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AdminColors.textoPrincipal,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _novaNotificacao,
                  icon: const Icon(Icons.add),
                  label: const Text('Nova Notificação'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(child: _NotificacoesContent(provider: provider)),
          ],
        ),
      ),
    );
  }
}

class _NotificacoesContent extends StatelessWidget {
  const _NotificacoesContent({required this.provider});

  final AdminNotificacoesProvider provider;

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

    if (provider.notificacoes.isEmpty) {
      return const Center(
        child: Text(
          'Nenhuma notificação cadastrada.',
          style: TextStyle(color: AdminColors.cinzaTexto),
        ),
      );
    }

    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Título')),
            DataColumn(label: Text('Público')),
            DataColumn(label: Text('Tipo')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Mensagem')),
            DataColumn(label: Text('Ações')),
          ],
          rows: provider.notificacoes.map((notificacao) {
            return DataRow(
              cells: [
                DataCell(Text(notificacao.titulo)),
                DataCell(Text(notificacao.publico)),
                DataCell(Text(notificacao.tipo)),
                DataCell(Chip(label: Text(notificacao.status))),
                DataCell(Text(notificacao.mensagem)),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        tooltip: 'Enviar',
                        onPressed: () => context
                            .read<AdminNotificacoesProvider>()
                            .enviar(notificacao.id),
                        icon: const Icon(Icons.send),
                      ),
                      IconButton(
                        tooltip: 'Cancelar',
                        onPressed: () => context
                            .read<AdminNotificacoesProvider>()
                            .cancelar(notificacao.id),
                        icon: const Icon(Icons.cancel),
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
  }
}

class _NotificacaoDialog extends StatefulWidget {
  const _NotificacaoDialog();

  @override
  State<_NotificacaoDialog> createState() => _NotificacaoDialogState();
}

class _NotificacaoDialogState extends State<_NotificacaoDialog> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _mensagemController = TextEditingController();
  String _publico = 'todos';
  String _tipo = 'informativo';

  @override
  void dispose() {
    _tituloController.dispose();
    _mensagemController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;

    final usuario = context.read<AdminAuthProvider>().usuario;

    final notificacao = NotificacaoAdminModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      titulo: _tituloController.text.trim(),
      mensagem: _mensagemController.text.trim(),
      publico: _publico,
      tipo: _tipo,
      status: 'rascunho',
      criadoPor: usuario?.email ?? 'admin',
    );

    final sucesso = await context
        .read<AdminNotificacoesProvider>()
        .salvar(notificacao);

    if (!mounted) return;

    if (sucesso) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Notificação cadastrada com sucesso.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final carregando = context.watch<AdminNotificacoesProvider>().carregando;

    return AlertDialog(
      title: const Text('Nova Notificação'),
      content: SizedBox(
        width: 560,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _tituloController,
                  decoration: const InputDecoration(
                    labelText: 'Título',
                    border: OutlineInputBorder(),
                  ),
                  validator: _obrigatorio,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _publico,
                        decoration: const InputDecoration(
                          labelText: 'Público',
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'todos', child: Text('Todos')),
                          DropdownMenuItem(value: 'ativos', child: Text('Ativos')),
                          DropdownMenuItem(value: 'ranking', child: Text('Ranking')),
                          DropdownMenuItem(value: 'filial', child: Text('Filial')),
                        ],
                        onChanged: (value) {
                          if (value != null) setState(() => _publico = value);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _tipo,
                        decoration: const InputDecoration(
                          labelText: 'Tipo',
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'informativo', child: Text('Informativo')),
                          DropdownMenuItem(value: 'frete', child: Text('Frete')),
                          DropdownMenuItem(value: 'beneficio', child: Text('Benefício')),
                          DropdownMenuItem(value: 'alerta', child: Text('Alerta')),
                        ],
                        onChanged: (value) {
                          if (value != null) setState(() => _tipo = value);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _mensagemController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Mensagem',
                    border: OutlineInputBorder(),
                  ),
                  validator: _obrigatorio,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: carregando ? null : () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton.icon(
          onPressed: carregando ? null : _salvar,
          icon: const Icon(Icons.save),
          label: Text(carregando ? 'Salvando...' : 'Salvar'),
        ),
      ],
    );
  }

  String? _obrigatorio(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }
}
