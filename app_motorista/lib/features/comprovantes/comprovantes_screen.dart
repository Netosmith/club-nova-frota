import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../core/providers/auth_provider.dart';
import '../../core/providers/comprovantes_provider.dart';
import '../../core/providers/ordens_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/models/ordem_model.dart';

class ComprovantesScreen extends StatefulWidget {
  const ComprovantesScreen({super.key});

  @override
  State<ComprovantesScreen> createState() => _ComprovantesScreenState();
}

class _ComprovantesScreenState extends State<ComprovantesScreen> {
  final _imagePicker = ImagePicker();
  OrdemModel? _ordemSelecionada;
  bool _ordensIniciadas = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_ordensIniciadas) {
      final usuario = context.read<AuthProvider>().usuario;
      if (usuario != null) {
        context.read<OrdensProvider>().acompanharOrdensDoMotorista(usuario.uid);
      }
      _ordensIniciadas = true;
    }
  }

  Future<void> _enviarFoto() async {
    final imagem = await _imagePicker.pickImage(source: ImageSource.camera);
    if (imagem == null) return;

    await _enviarArquivo(
      arquivo: File(imagem.path),
      nomeArquivo: imagem.name,
    );
  }

  Future<void> _enviarPdf() async {
    final resultado = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (resultado == null || resultado.files.single.path == null) return;

    final arquivoSelecionado = resultado.files.single;

    await _enviarArquivo(
      arquivo: File(arquivoSelecionado.path!),
      nomeArquivo: arquivoSelecionado.name,
    );
  }

  Future<void> _enviarArquivo({
    required File arquivo,
    required String nomeArquivo,
  }) async {
    final usuario = context.read<AuthProvider>().usuario;

    if (_ordemSelecionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione uma ordem para enviar o comprovante.')),
      );
      return;
    }

    if (usuario == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Faça login novamente para enviar comprovante.')),
      );
      return;
    }

    final sucesso = await context.read<ComprovantesProvider>().enviarComprovante(
          arquivo: arquivo,
          motoristaId: usuario.uid,
          ordemId: _ordemSelecionada!.id,
          nomeArquivo: nomeArquivo,
        );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          sucesso
              ? 'Comprovante enviado com sucesso.'
              : 'Não foi possível enviar o comprovante.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final comprovantesProvider = context.watch<ComprovantesProvider>();
    final ordensProvider = context.watch<OrdensProvider>();
    final carregando = comprovantesProvider.carregando;

    return Scaffold(
      appBar: AppBar(title: const Text('Anexar Comprovante')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Card(
            child: Padding(
              padding: EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Envio de documentos',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Selecione uma ordem e anexe o comprovante de descarga, canhoto ou PDF da viagem.',
                    style: TextStyle(color: AppColors.cinzaTexto),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _SelecionarOrdemCard(
            ordens: ordensProvider.ordens,
            carregando: ordensProvider.carregando,
            ordemSelecionada: _ordemSelecionada,
            onChanged: (ordem) {
              setState(() {
                _ordemSelecionada = ordem;
              });
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: carregando ? null : _enviarFoto,
            icon: const Icon(Icons.camera_alt),
            label: Text(carregando ? 'Enviando...' : 'Enviar Foto'),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: carregando ? null : _enviarPdf,
            icon: const Icon(Icons.picture_as_pdf),
            label: const Text('Enviar PDF'),
          ),
          const SizedBox(height: 24),
          const Text(
            'Histórico',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: Icon(
                comprovantesProvider.ultimoArquivoUrl == null
                    ? Icons.info_outline
                    : Icons.check_circle,
                color: comprovantesProvider.ultimoArquivoUrl == null
                    ? AppColors.azulPrincipal
                    : AppColors.verdePrincipal,
              ),
              title: Text(
                comprovantesProvider.ultimoArquivoUrl == null
                    ? 'Nenhum comprovante enviado nesta sessão'
                    : 'Último comprovante enviado',
              ),
              subtitle: Text(
                comprovantesProvider.ultimoArquivoUrl == null
                    ? 'Os envios aparecerão aqui.'
                    : comprovantesProvider.ultimoArquivoUrl!,
              ),
            ),
          ),
          if (comprovantesProvider.erro != null) ...[
            const SizedBox(height: 12),
            Text(
              comprovantesProvider.erro!,
              style: const TextStyle(color: Colors.red),
            ),
          ],
        ],
      ),
    );
  }
}

class _SelecionarOrdemCard extends StatelessWidget {
  const _SelecionarOrdemCard({
    required this.ordens,
    required this.carregando,
    required this.ordemSelecionada,
    required this.onChanged,
  });

  final List<OrdemModel> ordens;
  final bool carregando;
  final OrdemModel? ordemSelecionada;
  final ValueChanged<OrdemModel?> onChanged;

  @override
  Widget build(BuildContext context) {
    if (carregando) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (ordens.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Text(
            'Nenhuma ordem disponível para anexar comprovante.',
            style: TextStyle(color: AppColors.cinzaTexto),
          ),
        ),
      );
    }

    return DropdownButtonFormField<OrdemModel>(
      value: ordemSelecionada,
      decoration: const InputDecoration(
        labelText: 'Selecionar ordem',
        border: OutlineInputBorder(),
      ),
      items: ordens.map((ordem) {
        return DropdownMenuItem<OrdemModel>(
          value: ordem,
          child: Text('Ordem ${ordem.id} - ${ordem.status}'),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
