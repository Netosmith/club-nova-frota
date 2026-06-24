import 'package:flutter/material.dart';

import '../../core/services/admin_beneficios_service.dart';
import '../../core/services/admin_comprovantes_service.dart';
import '../../core/services/admin_fretes_service.dart';
import '../../core/services/admin_motoristas_service.dart';
import '../../core/services/admin_ordens_service.dart';
import '../../core/services/admin_pedidos_beneficios_service.dart';
import '../../core/services/admin_pontos_service.dart';
import '../../core/services/admin_ranking_service.dart';
import '../../core/theme/admin_colors.dart';
import '../../shared/widgets/admin_layout.dart';

class RelatoriosScreen extends StatelessWidget {
  const RelatoriosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final motoristasService = AdminMotoristasService();
    final fretesService = AdminFretesService();
    final ordensService = AdminOrdensService();
    final comprovantesService = AdminComprovantesService();
    final pontosService = AdminPontosService();
    final rankingService = AdminRankingService();
    final beneficiosService = AdminBeneficiosService();
    final pedidosService = AdminPedidosBeneficiosService();

    return AdminLayout(
      title: 'Relatórios',
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Relatórios gerenciais',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AdminColors.textoPrincipal,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Visão consolidada das principais áreas do Club Nova Frota.',
                style: TextStyle(color: AdminColors.cinzaTexto),
              ),
              const SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 2.4,
                children: [
                  _ContadorCard(
                    titulo: 'Motoristas',
                    icone: Icons.people,
                    stream: motoristasService.listarMotoristas().map((lista) => lista.length),
                  ),
                  _ContadorCard(
                    titulo: 'Fretes',
                    icone: Icons.local_shipping,
                    stream: fretesService.listarFretes().map((lista) => lista.length),
                  ),
                  _ContadorCard(
                    titulo: 'Ordens',
                    icone: Icons.assignment,
                    stream: ordensService.listarOrdens().map((lista) => lista.length),
                  ),
                  _ContadorCard(
                    titulo: 'Comprovantes',
                    icone: Icons.upload_file,
                    stream: comprovantesService.listarComprovantes().map((lista) => lista.length),
                  ),
                  _ContadorCard(
                    titulo: 'Movimentações de Pontos',
                    icone: Icons.stars,
                    stream: pontosService.listarPontos().map((lista) => lista.length),
                  ),
                  _ContadorCard(
                    titulo: 'Ranking',
                    icone: Icons.emoji_events,
                    stream: rankingService.listarRanking().map((lista) => lista.length),
                  ),
                  _ContadorCard(
                    titulo: 'Benefícios',
                    icone: Icons.card_giftcard,
                    stream: beneficiosService.listarBeneficios().map((lista) => lista.length),
                  ),
                  _ContadorCard(
                    titulo: 'Trocas',
                    icone: Icons.redeem,
                    stream: pedidosService.listarPedidos().map((lista) => lista.length),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const _RelatorioOrientacoes(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContadorCard extends StatelessWidget {
  const _ContadorCard({
    required this.titulo,
    required this.icone,
    required this.stream,
  });

  final String titulo;
  final IconData icone;
  final Stream<int> stream;

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
              child: StreamBuilder<int>(
                stream: stream,
                builder: (context, snapshot) {
                  final valor = snapshot.data ?? 0;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$valor',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: AdminColors.textoPrincipal,
                        ),
                      ),
                      Text(
                        titulo,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: AdminColors.cinzaTexto),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RelatorioOrientacoes extends StatelessWidget {
  const _RelatorioOrientacoes();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Próximas evoluções dos relatórios',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AdminColors.textoPrincipal,
              ),
            ),
            SizedBox(height: 12),
            Text('• Filtro por período'),
            Text('• Exportação em PDF'),
            Text('• Exportação em Excel'),
            Text('• Gráficos de pontos e ranking'),
            Text('• Relatórios por filial, cliente e motorista'),
          ],
        ),
      ),
    );
  }
}
