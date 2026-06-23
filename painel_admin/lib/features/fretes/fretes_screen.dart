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

  Future<void> _abrirFormularioNovoFrete() async {
    await showDialog<void>(
      context: context,
      builder: (_) => const _FreteDialog(),
    );
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
                  onPressed: _abrirFormularioNovoFrete,
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
                onPressed: () => showDialog<void>(
                  context: context,
                  builder: (_) => _FreteDialog(frete: frete),
                ),
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

class _FreteDialog extends StatefulWidget {
  const _FreteDialog({this.frete});

  final FreteAdminModel? frete;

  @override
  State<_FreteDialog> createState() => _FreteDialogState();
}

class _FreteDialogState extends State<_FreteDialog> {
  final _formKey = GlobalKey<FormState>();
  final _clienteController = TextEditingController();
  final _origemController = TextEditingController();
  final _destinoController = TextEditingController();
  final _produtoController = TextEditingController();
  final _valorController = TextEditingController();
  final _pesoController = TextEditingController();
  final _dataController = TextEditingController();
  final _observacoesController = TextEditingController();

  bool get _editando => widget.frete != null;

  @override
  void initState() {
    super.initState();

    final frete = widget.frete;
    if (frete != null) {
      _clienteController.text = frete.cliente;
      _origemController.text = frete.origem;
      _destinoController.text = frete.destino;
      _produtoController.text = frete.produto;
      _valorController.text = frete.valor.toStringAsFixed(2);
      _pesoController.text = frete.pesoEstimado.toStringAsFixed(2);
      _dataController.text = frete.dataCarregamento;
      _observacoesController.text = frete.observacoes;
    }
  }

  @override
  void dispose() {
    _clienteController.dispose();
    _origemController.dispose();
    _destinoController.dispose();
    _produtoController.dispose();
    _valorController.dispose();
    _pesoController.dispose();
    _dataController.dispose();
    _observacoesController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;

    final freteAtual = widget.frete;

    final frete = FreteAdminModel(
      id: freteAtual?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      cliente: _clienteController.text.trim(),
      origem: _origemController.text.trim(),
      destino: _destinoController.text.trim(),
      produto: _produtoController.text.trim(),
      valor: double.tryParse(_valorController.text.replaceAll(',', '.')) ?? 0,
      pesoEstimado: double.tryParse(_pesoController.text.replaceAll(',', '.')) ?? 0,
      dataCarregamento: _dataController.text.trim(),
      observacoes: _observacoesController.text.trim(),
      status: freteAtual?.status ?? 'rascunho',
      criadoPor: freteAtual?.criadoPor ?? 'admin',
    );

    final sucesso = await context.read<AdminFretesProvider>().salvarFrete(frete);

    if (!mounted) return;

    if (sucesso) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _editando
                ? 'Frete atualizado com sucesso.'
                : 'Frete cadastrado com sucesso.',
          ),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Não foi possível salvar o frete.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final carregando = context.watch<AdminFretesProvider>().carregando;

    return AlertDialog(
      title: Text(_editando ? 'Editar Frete' : 'Novo Frete'),
      content: SizedBox(
        width: 620,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _campoObrigatorio(_clienteController, 'Cliente'),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _campoObrigatorio(_origemController, 'Origem')),
                    const SizedBox(width: 12),
                    Expanded(child: _campoObrigatorio(_destinoController, 'Destino')),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _campoObrigatorio(_produtoController, 'Produto')),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _dataController,
                        decoration: const InputDecoration(
                          labelText: 'Data de carregamento',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _campoNumero(
                        controller: _valorController,
                        label: 'Valor por tonelada',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _campoNumero(
                        controller: _pesoController,
                        label: 'Peso estimado',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _observacoesController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Observações',
                    border: OutlineInputBorder(),
                  ),
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

  TextFormField _campoObrigatorio(
    TextEditingController controller,
    String label,
  ) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );
  }

  TextFormField _campoNumero({
    required TextEditingController controller,
    required String label,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        final numero = double.tryParse((value ?? '').replaceAll(',', '.'));
        if (numero == null || numero <= 0) {
          return 'Informe um valor válido';
        }
        return null;
      },
    );
  }
}
