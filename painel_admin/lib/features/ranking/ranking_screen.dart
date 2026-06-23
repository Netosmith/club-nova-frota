import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/admin_ranking_provider.dart';
import '../../core/theme/admin_colors.dart';
import '../../shared/widgets/admin_layout.dart';
import 'widgets/ranking_card.dart';
import 'widgets/top_motoristas_table.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  bool _iniciado = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_iniciado) {
      context.read<AdminRankingProvider>().acompanharRanking();
      _iniciado = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AdminRankingProvider>();

    return AdminLayout(
      title: 'Ranking',
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Ranking e pontuação dos motoristas',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AdminColors.textoPrincipal,
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 2.4,
              children: [
                RankingCard(
                  titulo: 'Pontos distribuídos',
                  valor: '${provider.pontosTotais}',
                  icone: Icons.stars,
                ),
                RankingCard(
                  titulo: 'Viagens concluídas',
                  valor: '${provider.viagensTotais}',
                  icone: Icons.local_shipping,
                ),
                RankingCard(
                  titulo: 'Comprovantes aprovados',
                  valor: '${provider.comprovantesTotais}',
                  icone: Icons.upload_file,
                ),
                RankingCard(
                  titulo: 'Indicações realizadas',
                  valor: '${provider.indicacoesTotais}',
                  icone: Icons.group_add,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(child: _RankingContent(provider: provider)),
          ],
        ),
      ),
    );
  }
}

class _RankingContent extends StatelessWidget {
  const _RankingContent({required this.provider});

  final AdminRankingProvider provider;

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

    if (provider.ranking.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum ranking encontrado.',
          style: TextStyle(color: AdminColors.cinzaTexto),
        ),
      );
    }

    return TopMotoristasTable(ranking: provider.ranking);
  }
}
