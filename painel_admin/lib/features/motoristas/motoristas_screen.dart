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

  Future<void> _abrirFormularioNovoMotorista() async {
    await showDialog<void>(
      context: context,
      builder: (_) => const _MotoristaDialog(),
    );
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
                  onPressed: _abrirFormularioNovoMotorista,
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
        scrollDirection: Axis.horizontal,
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
                onPressed: () => showDialog<void>(
                  context: context,
                  builder: (_) => _MotoristaDialog(motorista: motorista),
                ),
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

class _MotoristaDialog extends StatefulWidget {
  const _MotoristaDialog({this.motorista});

  final MotoristaAdminModel? motorista;

  @override
  State<_MotoristaDialog> createState() => _MotoristaDialogState();
}

class _MotoristaDialogState extends State<_MotoristaDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _placaController = TextEditingController();
  final _categoriaController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _ufController = TextEditingController();

  bool get _editando => widget.motorista != null;

  @override
  void initState() {
    super.initState();

    final motorista = widget.motorista;
    if (motorista != null) {
      _nomeController.text = motorista.nome;
      _cpfController.text = motorista.cpf;
      _telefoneController.text = motorista.telefone;
      _emailController.text = motorista.email;
      _placaController.text = motorista.placa;
      _categoriaController.text = motorista.categoria;
      _cidadeController.text = motorista.cidade;
      _ufController.text = motorista.uf;
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _telefoneController.dispose();
    _emailController.dispose();
    _placaController.dispose();
    _categoriaController.dispose();
    _cidadeController.dispose();
    _ufController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;

    final motoristaAtual = widget.motorista;
    final id = motoristaAtual?.id ?? DateTime.now().millisecondsSinceEpoch.toString();

    final motorista = MotoristaAdminModel(
      id: id,
      usuarioId: motoristaAtual?.usuarioId ?? id,
      nome: _nomeController.text.trim(),
      cpf: _cpfController.text.trim(),
      telefone: _telefoneController.text.trim(),
      email: _emailController.text.trim(),
      placa: _placaController.text.trim().toUpperCase(),
      categoria: _categoriaController.text.trim(),
      cidade: _cidadeController.text.trim(),
      uf: _ufController.text.trim().toUpperCase(),
      ativo: motoristaAtual?.ativo ?? true,
      pontos: motoristaAtual?.pontos ?? 0,
      medalha: motoristaAtual?.medalha ?? 'bronze',
    );

    final sucesso = await context
        .read<AdminMotoristasProvider>()
        .salvarMotorista(motorista);

    if (!mounted) return;

    if (sucesso) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _editando
                ? 'Motorista atualizado com sucesso.'
                : 'Motorista cadastrado com sucesso.',
          ),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Não foi possível salvar o motorista.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final carregando = context.watch<AdminMotoristasProvider>().carregando;

    return AlertDialog(
      title: Text(_editando ? 'Editar Motorista' : 'Novo Motorista'),
      content: SizedBox(
        width: 620,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _campoObrigatorio(_nomeController, 'Nome'),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _campoObrigatorio(_cpfController, 'CPF')),
                    const SizedBox(width: 12),
                    Expanded(child: _campoObrigatorio(_telefoneController, 'Telefone')),
                  ],
                ),
                const SizedBox(height: 12),
                _campoObrigatorio(_emailController, 'E-mail'),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _campoObrigatorio(_placaController, 'Placa')),
                    const SizedBox(width: 12),
                    Expanded(child: _campoObrigatorio(_categoriaController, 'Categoria')),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _campoObrigatorio(_cidadeController, 'Cidade')),
                    const SizedBox(width: 12),
                    SizedBox(width: 120, child: _campoObrigatorio(_ufController, 'UF')),
                  ],
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
}
