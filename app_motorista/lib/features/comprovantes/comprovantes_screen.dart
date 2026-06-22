import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class ComprovantesScreen extends StatelessWidget {
  const ComprovantesScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.camera_alt),
              label: const Text('Enviar Foto'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('Enviar PDF'),
            ),
            const SizedBox(height: 24),
            const Text(
              'Histórico',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            const Card(
              child: ListTile(
                leading: Icon(Icons.check_circle, color: AppColors.verdePrincipal),
                title: Text('Nenhum comprovante pendente'),
                subtitle: Text('Os envios aparecerão aqui.'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
