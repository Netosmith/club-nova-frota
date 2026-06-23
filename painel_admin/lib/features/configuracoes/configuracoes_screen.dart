import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/admin_usuarios_provider.dart';
import '../../core/theme/admin_colors.dart';
import '../../shared/models/usuario_admin_model.dart';
import '../../shared/widgets/admin_layout.dart';

class ConfiguracoesScreen extends StatefulWidget {
  const ConfiguracoesScreen({super.key});

  @override
  State<ConfiguracoesScreen> createState() => _ConfiguracoesScreenState();
}

class _ConfiguracoesScreenState extends State<ConfiguracoesScreen> {
  bool _iniciado = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_iniciado) {
      context.read<AdminUsuariosProvider>().acompanharUsuarios();
      _iniciado = true;
    }
  }

  Future<void> _abrirFormularioUsuario() async {
    await showDialog<void>(
      context: context,
      builder: (_) => const _UsuarioPainelDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AdminUsuariosProvider>();

    return AdminLayout(
      title: 'Configurações',
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Usuários do Painel',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AdminColors.textoPrincipal,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _abrirFormularioUsuario,
                  icon: const Icon(Icons.add),
                  label: const Text('Novo Usuário'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(child: _UsuariosContent(provider: provider)),
          ],
        ),
      ),
    );
  }
}

class _UsuariosContent extends StatelessWidget {
  const _UsuariosContent({required this.provider});

  final AdminUsuariosProvider provider;

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

    if (provider.usuarios.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum usuário do painel cadastrado.',
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
            DataColumn(label: Text('E-mail')),
            DataColumn(label: Text('Perfil')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Ações')),
          ],
          rows: provider.usuarios.map((usuario) {
            return _usuarioRow(context, usuario);
          }).toList(),
        ),
      ),
    );
  }

  DataRow _usuarioRow(BuildContext context, UsuarioAdminModel usuario) {
    return DataRow(
      cells: [
        DataCell(Text(usuario.nome)),
        DataCell(Text(usuario.email)),
        DataCell(Text(usuario.perfil)),
        DataCell(
          Chip(
            label: Text(usuario.ativo ? 'Ativo' : 'Bloqueado'),
            backgroundColor: usuario.ativo
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
                  builder: (_) => _UsuarioPainelDialog(usuario: usuario),
                ),
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                tooltip: usuario.ativo ? 'Bloquear' : 'Ativar',
                onPressed: () {
                  final adminProvider = context.read<AdminUsuariosProvider>();
                  if (usuario.ativo) {
                    adminProvider.bloquearUsuario(usuario.id);
                  } else {
                    adminProvider.ativarUsuario(usuario.id);
                  }
                },
                icon: Icon(usuario.ativo ? Icons.block : Icons.check_circle),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _UsuarioPainelDialog extends StatefulWidget {
  const _UsuarioPainelDialog({this.usuario});

  final UsuarioAdminModel? usuario;

  @override
  State<_UsuarioPainelDialog> createState() => _UsuarioPainelDialogState();
}

class _UsuarioPainelDialogState extends State<_UsuarioPainelDialog> {
  final _formKey = GlobalKey<FormState>();
  final _uidController = TextEditingController();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  String _perfilSelecionado = 'operacional';

  bool get _editando => widget.usuario != null;

  @override
  void initState() {
    super.initState();

    final usuario = widget.usuario;
    if (usuario != null) {
      _uidController.text = usuario.id;
      _nomeController.text = usuario.nome;
      _emailController.text = usuario.email;
      _perfilSelecionado = usuario.perfil.isEmpty ? 'operacional' : usuario.perfil;
    }
  }

  @override
  void dispose() {
    _uidController.dispose();
    _nomeController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;

    final usuarioAtual = widget.usuario;
    final usuario = UsuarioAdminModel(
      id: usuarioAtual?.id ?? _uidController.text.trim(),
      nome: _nomeController.text.trim(),
      email: _emailController.text.trim(),
      perfil: _perfilSelecionado,
      ativo: usuarioAtual?.ativo ?? true,
    );

    final sucesso = await context.read<AdminUsuariosProvider>().salvarUsuario(usuario);

    if (!mounted) return;

    if (sucesso) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _editando
                ? 'Usuário atualizado com sucesso.'
                : 'Usuário cadastrado com sucesso.',
          ),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Não foi possível salvar o usuário.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final carregando = context.watch<AdminUsuariosProvider>().carregando;

    return AlertDialog(
      title: Text(_editando ? 'Editar Usuário' : 'Novo Usuário do Painel'),
      content: SizedBox(
        width: 520,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!_editando) ...[
                  TextFormField(
                    controller: _uidController,
                    decoration: const InputDecoration(
                      labelText: 'UID do Firebase Auth',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Informe o UID do usuário';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                ],
                _campoObrigatorio(_nomeController, 'Nome'),
                const SizedBox(height: 12),
                _campoObrigatorio(_emailController, 'E-mail'),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _perfilSelecionado,
                  decoration: const InputDecoration(
                    labelText: 'Perfil',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'admin', child: Text('Admin')),
                    DropdownMenuItem(value: 'coordenador', child: Text('Coordenador')),
                    DropdownMenuItem(value: 'operacional', child: Text('Operacional')),
                    DropdownMenuItem(value: 'comercial', child: Text('Comercial')),
                    DropdownMenuItem(value: 'financeiro', child: Text('Financeiro')),
                  ],
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() => _perfilSelecionado = value);
                  },
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
