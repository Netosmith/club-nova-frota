import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meu Perfil')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(
            child: Padding(
              padding: EdgeInsets.all(18),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 34,
                    backgroundColor: AppColors.azulPrincipal,
                    child: Icon(Icons.person, color: AppColors.branco, size: 34),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Motorista Club Nova Frota',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                        ),
                        SizedBox(height: 4),
                        Text('Medalha: Bronze', style: TextStyle(color: AppColors.cinzaTexto)),
                        Text('Pontos: 0', style: TextStyle(color: AppColors.verdePrincipal)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: Icon(Icons.local_shipping, color: AppColors.azulPrincipal),
              title: Text('Veículo'),
              subtitle: Text('Placa e categoria serão exibidas aqui.'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.history, color: AppColors.azulPrincipal),
              title: Text('Histórico'),
              subtitle: Text('Viagens e ordens finalizadas.'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.settings, color: AppColors.azulPrincipal),
              title: Text('Configurações'),
              subtitle: Text('Senha, notificações e dados da conta.'),
            ),
          ),
        ],
      ),
    );
  }
}
