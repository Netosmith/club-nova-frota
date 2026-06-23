import 'package:flutter/material.dart';

import '../../../core/theme/admin_colors.dart';

class RankingCard extends StatelessWidget {
  const RankingCard({
    super.key,
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
                children: [
                  Text(
                    valor,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AdminColors.textoPrincipal,
                    ),
                  ),
                  const SizedBox(height: 4),
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
