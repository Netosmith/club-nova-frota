import '../../shared/models/ranking_admin_model.dart';
import '../services/admin_ranking_service.dart';

class AdminRankingRepository {
  AdminRankingRepository({AdminRankingService? rankingService})
      : _rankingService = rankingService ?? AdminRankingService();

  final AdminRankingService _rankingService;

  Stream<List<RankingAdminModel>> listarRanking() {
    return _rankingService.listarRanking();
  }

  Future<void> salvarRanking(RankingAdminModel ranking) {
    return _rankingService.salvarRanking(ranking);
  }
}
