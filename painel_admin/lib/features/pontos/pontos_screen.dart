import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/admin_auth_provider.dart';
import '../../core/providers/admin_pontos_provider.dart';
import '../../core/theme/admin_colors.dart';
import '../../shared/models/pontos_admin_model.dart';
import '../../shared/widgets/admin_layout.dart';

class PontosScreen extends StatefulWidget {
  const PontosScreen({super.key});

  @override
  State<PontosScreen> createState() => _PontosScreenState();
}

class _PontosScreenState extends State<PontosScreen> {
  bool _iniciado = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_iniciado) {
      context.read<AdminPontosProvider>().acompanharPontos();
      _iniciado = true;
    }
  }

  Future<void> _abrirNovaMovimentacao() async {
    await showDialog<void>(
      context: context,
      builder: (_) => const _NovaMovimentacaoDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AdminPontosProvider>();

    return AdminLayout(
      title: 'Pontos',
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Movimentações de pontos',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AdminColors.textoPrincipal,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _abrirNovaMovimentacao,
                  icon: const Icon(Icons.add),
                  label: const Text('Nova Movimentação'),
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
                _ResumoPontosCard(
                  titulo: 'Créditos',
                  valor: '${provider.creditosTotais}',
                  icone: Icons.add_circle,
                ),
                _ResumoPontosCard(
                  titulo: 'Débitos',
                  valor: '${provider.debitosTotais}',
                  icone: Icons.remove_circle,
                ),
                _ResumoPontosCard(
                  titulo: 'Saldo movimentado',
                  valor: '${provider.saldoMovimentado}',
                  icone: Icons.stars,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(child: _PontosContent(provider: provider)),
          ],
        ),
      ),
    );
  }
}

class _ResumoPontosCard extends StatelessWidget {
  const _ResumoPontosCard({
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

class _PontosContent extends StatelessWidget {
  const _PontosContent({required this.provider});

  final AdminPontosProvider provider;

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

    if (provider.movimentacoes.isEmpty) {
      return const Center(
        child: Text(
          'Nenhuma movimentação encontrada.',
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
            DataColumn(label: Text('Tipo')),
            DataColumn(label: Text('Pontos')),
            DataColumn(label: Text('Origem')),
            DataColumn(label: Text('Descrição')),
            DataColumn(label: Text('Criado por')),
          ],
          rows: provider.movimentacoes.map((item) {
            return DataRow(
              cells: [
                DataCell(Text(item.nomeMotorista)),
                DataCell(Text(item.tipo)),
                DataCell(Text('${item.pontos}')),
                DataCell(Text(item.origem)),
                DataCell(Text(item.descricao)),
                DataCell(Text(item.criadoPor)),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _NovaMovimentacaoDialog extends StatefulWidget {
  const _NovaMovimentacaoDialog();

  @override
  State<_NovaMovimentacaoDialog> createState() => _NovaMovimentacaoDialogState();
}

class _NovaMovimentacaoDialogState extends State<_NovaMovimentacaoDialog> {
  final _formKey = GlobalKey<FormState>();
  final _motoristaIdController = TextEditingController();
  final _nomeMotoristaController = TextEditingController();
  final _pontosController = TextEditingController();
  final _descricaoController = TextEditingController();
  String _tipo = 'credito';

  @override
  void dispose() {
    _motoristaIdController.dispose();
    _nomeMotoristaController.dispose();
    _pontosController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;

    final pontosInformados = int.tryParse(_pontosController.text.trim()) ?? 0;
    final pontos = _tipo == 'debito' || _tipo == 'resgate'
        ? pontosInformados.abs() * -1
        : pontosInformados.abs();

    final usuario = context.read<AdminAuthProvider>().usuario;

    final movimentacao = PontosAdminModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      motoristaId: _motoristaIdController.text.trim(),
      nomeMotorista: _nomeMotoristaController.text.trim(),
      tipo: _tipo,
      pontos: pontos,
      descricao: _descricaoController.text.trim(),
      origem: 'manual',
      referenciaId: '',
      criadoPor: usuario?.email ?? 'admin',
    );

    final sucesso = await context
        .read<AdminPontosProvider>()
        .salvarMovimentacao(movimentacao);

    if (!mounted) return;

    if (sucesso) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Movimentação registrada com sucesso.')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Não foi possível registrar a movimentação.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final carregando = context.watch<AdminPontosProvider>().carregando;

    return AlertDialog(
      title: const Text('Nova Movimentação de Pontos'),
      content: SizedBox(
        width: 560,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _motoristaIdController,
                  decoration: const InputDecoration(
                    labelText: 'ID do motorista',
                    border: OutlineInputBorder(),
                  ),
                  validator: _obrigatorio,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _nomeMotoristaController,
                  decoration: const InputDecoration(
                    labelText: 'Nome do motorista',
                    border: OutlineInputBorder(),
                  ),
                  validator: _obrigatorio,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _tipo,
                        decoration: const InputDecoration(
                          labelText: 'Tipo',
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'credito', child: Text('Crédito')),
                          DropdownMenuItem(value: 'bonus', child: Text('Bônus')),
                          DropdownMenuItem(value: 'indicacao', child: Text('Indicação')),
                          DropdownMenuItem(value: 'debito', child: Text('Débito')),
                          DropdownMenuItem(value: 'resgate', child: Text('Resgate')),
                        ],
                        onChanged: (value) {
                          if (value != null) setState(() => _tipo = value);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _pontosController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Pontos',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          final numero = int.tryParse(value ?? '');
                          if (numero == null || numero <= 0) {
                            return 'Informe pontos válidos';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
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

  String? _obrigatorio(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }
}
