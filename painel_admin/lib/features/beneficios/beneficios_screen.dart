import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/admin_beneficios_provider.dart';
import '../../core/theme/admin_colors.dart';
import '../../shared/models/beneficio_admin_model.dart';
import '../../shared/widgets/admin_layout.dart';

class BeneficiosScreen extends StatefulWidget {
  const BeneficiosScreen({super.key});

  @override
  State<BeneficiosScreen> createState() => _BeneficiosScreenState();
}

class _BeneficiosScreenState extends State<BeneficiosScreen> {
  bool _iniciado = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_iniciado) {
      context.read<AdminBeneficiosProvider>().acompanharBeneficios();
      _iniciado = true;
    }
  }

  Future<void> _abrirFormularioNovoBeneficio() async {
    await showDialog<void>(
      context: context,
      builder: (_) => const _BeneficioDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AdminBeneficiosProvider>();

    return AdminLayout(
      title: 'Benefícios',
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Loja de pontos e benefícios',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AdminColors.textoPrincipal,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _abrirFormularioNovoBeneficio,
                  icon: const Icon(Icons.add),
                  label: const Text('Novo Benefício'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 2.8,
              children: [
                _ResumoBeneficioCard(
                  titulo: 'Benefícios cadastrados',
                  valor: '${provider.beneficios.length}',
                  icone: Icons.card_giftcard,
                ),
                _ResumoBeneficioCard(
                  titulo: 'Benefícios ativos',
                  valor: '${provider.beneficiosAtivos}',
                  icone: Icons.check_circle,
                ),
                _ResumoBeneficioCard(
                  titulo: 'Estoque total',
                  valor: '${provider.estoqueTotal}',
                  icone: Icons.inventory_2,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(child: _BeneficiosContent(provider: provider)),
          ],
        ),
      ),
    );
  }
}

class _ResumoBeneficioCard extends StatelessWidget {
  const _ResumoBeneficioCard({
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

class _BeneficiosContent extends StatelessWidget {
  const _BeneficiosContent({required this.provider});

  final AdminBeneficiosProvider provider;

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

    if (provider.beneficios.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum benefício cadastrado.',
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
            DataColumn(label: Text('Categoria')),
            DataColumn(label: Text('Parceiro')),
            DataColumn(label: Text('Pontos')),
            DataColumn(label: Text('Estoque')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Ações')),
          ],
          rows: provider.beneficios.map((beneficio) {
            return _beneficioRow(context, beneficio);
          }).toList(),
        ),
      ),
    );
  }

  DataRow _beneficioRow(BuildContext context, BeneficioAdminModel beneficio) {
    return DataRow(
      cells: [
        DataCell(Text(beneficio.titulo)),
        DataCell(Text(beneficio.categoria)),
        DataCell(Text(beneficio.parceiro.isEmpty ? '-' : beneficio.parceiro)),
        DataCell(Text('${beneficio.pontosNecessarios}')),
        DataCell(Text('${beneficio.estoque}')),
        DataCell(
          Chip(
            label: Text(beneficio.ativo ? 'Ativo' : 'Inativo'),
            backgroundColor: beneficio.ativo
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
                  builder: (_) => _BeneficioDialog(beneficio: beneficio),
                ),
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                tooltip: beneficio.ativo ? 'Inativar' : 'Ativar',
                onPressed: () {
                  final adminProvider = context.read<AdminBeneficiosProvider>();
                  if (beneficio.ativo) {
                    adminProvider.inativarBeneficio(beneficio.id);
                  } else {
                    adminProvider.ativarBeneficio(beneficio.id);
                  }
                },
                icon: Icon(beneficio.ativo ? Icons.block : Icons.check_circle),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BeneficioDialog extends StatefulWidget {
  const _BeneficioDialog({this.beneficio});

  final BeneficioAdminModel? beneficio;

  @override
  State<_BeneficioDialog> createState() => _BeneficioDialogState();
}

class _BeneficioDialogState extends State<_BeneficioDialog> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _categoriaController = TextEditingController();
  final _parceiroController = TextEditingController();
  final _pontosController = TextEditingController();
  final _estoqueController = TextEditingController();
  final _imagemUrlController = TextEditingController();

  bool get _editando => widget.beneficio != null;

  @override
  void initState() {
    super.initState();

    final beneficio = widget.beneficio;
    if (beneficio != null) {
      _tituloController.text = beneficio.titulo;
      _descricaoController.text = beneficio.descricao;
      _categoriaController.text = beneficio.categoria;
      _parceiroController.text = beneficio.parceiro;
      _pontosController.text = '${beneficio.pontosNecessarios}';
      _estoqueController.text = '${beneficio.estoque}';
      _imagemUrlController.text = beneficio.imagemUrl;
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    _categoriaController.dispose();
    _parceiroController.dispose();
    _pontosController.dispose();
    _estoqueController.dispose();
    _imagemUrlController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;

    final beneficioAtual = widget.beneficio;

    final beneficio = BeneficioAdminModel(
      id: beneficioAtual?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      titulo: _tituloController.text.trim(),
      descricao: _descricaoController.text.trim(),
      categoria: _categoriaController.text.trim(),
      parceiro: _parceiroController.text.trim(),
      pontosNecessarios: int.tryParse(_pontosController.text.trim()) ?? 0,
      estoque: int.tryParse(_estoqueController.text.trim()) ?? 0,
      imagemUrl: _imagemUrlController.text.trim(),
      ativo: beneficioAtual?.ativo ?? true,
    );

    final sucesso = await context
        .read<AdminBeneficiosProvider>()
        .salvarBeneficio(beneficio);

    if (!mounted) return;

    if (sucesso) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _editando
                ? 'Benefício atualizado com sucesso.'
                : 'Benefício cadastrado com sucesso.',
          ),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Não foi possível salvar o benefício.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final carregando = context.watch<AdminBeneficiosProvider>().carregando;

    return AlertDialog(
      title: Text(_editando ? 'Editar Benefício' : 'Novo Benefício'),
      content: SizedBox(
        width: 620,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _campoObrigatorio(_tituloController, 'Título'),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _campoObrigatorio(_categoriaController, 'Categoria')),
                    const SizedBox(width: 12),
                    Expanded(child: _campoTexto(_parceiroController, 'Parceiro')),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _campoNumero(
                        controller: _pontosController,
                        label: 'Pontos necessários',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _campoNumero(
                        controller: _estoqueController,
                        label: 'Estoque',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _campoTexto(_imagemUrlController, 'URL da imagem'),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _descricaoController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
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
      validator: _obrigatorio,
    );
  }

  TextFormField _campoTexto(
    TextEditingController controller,
    String label,
  ) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
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
        final numero = int.tryParse(value ?? '');
        if (numero == null || numero < 0) {
          return 'Informe um valor válido';
        }
        return null;
      },
    );
  }

  String? _obrigatorio(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }
}
