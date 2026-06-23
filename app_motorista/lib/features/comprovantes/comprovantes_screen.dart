import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../core/providers/auth_provider.dart';
import '../../core/providers/comprovantes_provider.dart';
import '../../core/theme/app_colors.dart';

class ComprovantesScreen extends StatefulWidget {
  const ComprovantesScreen({super.key});

  @override
  State<ComprovantesScreen> createState() => _ComprovantesScreenState();
}

class _ComprovantesScreenState extends State<ComprovantesScreen> {
  final _ordemController = TextEditingController();
  final _imagePicker = ImagePicker();

  @override
  void dispose() {
    _ordemController.dispose();
    super.dispose();
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
    final ordemId = _ordemController.text.trim();
    final usuario = context.read<AuthProvider>().usuario;

    if (ordemId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe o ID da ordem.')),
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
          ordemId: ordemId,
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
    final carregando = comprovantesProvider.carregando;

    return Scaffold(
      appBar: AppBar(title: const Text('Anexar Comprovante')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      'Anexe o comprovante de descarga, canhoto ou PDF da viagem.',
                      style: TextStyle(color: AppColors.cinzaTexto),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _ordemController,
              decoration: const InputDecoration(
                labelText: 'ID da ordem',
                border: OutlineInputBorder(),
              ),
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
      ),
    );
  }
}
