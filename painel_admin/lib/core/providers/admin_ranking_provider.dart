import 'package:flutter/material.dart';

import '../../shared/models/ranking_admin_model.dart';
import '../repositories/admin_ranking_repository.dart';

class AdminRankingProvider extends ChangeNotifier {
  AdminRankingProvider({AdminRankingRepository? rankingRepository})
      : _rankingRepository = rankingRepository ?? AdminRankingRepository();

  final AdminRankingRepository _rankingRepository;

  List<RankingAdminModel> _ranking = [];
  bool _carregando = false;
  String? _erro;

  List<RankingAdminModel> get ranking => _ranking;
  bool get carregando => _carregando;
  String? get erro => _erro;

  int get pontosTotais {
    return _ranking.fold<int>(0, (total, item) => total + item.pontos);
  }

  int get viagensTotais {
    return _ranking.fold<int>(0, (total, item) => total + item.viagens);
  }

  int get comprovantesTotais {
    return _ranking.fold<int>(0, (total, item) => total + item.comprovantes);
  }

  int get indicacoesTotais {
    return _ranking.fold<int>(0, (total, item) => total + item.indicacoes);
  }

  void acompanharRanking() {
    _carregando = true;
    notifyListeners();

    _rankingRepository.listarRanking().listen(
      (lista) {
        _ranking = lista;
        _carregando = false;
        _erro = null;
        notifyListeners();
      },
      onError: (_) {
        _erro = 'Não foi possível carregar o ranking.';
        _carregando = false;
        notifyListeners();
      },
    );
  }

  Future<bool> salvarRanking(RankingAdminModel ranking) async {
    _carregando = true;
    _erro = null;
    notifyListeners();

    try {
      await _rankingRepository.salvarRanking(ranking);
      return true;
    } catch (_) {
      _erro = 'Não foi possível salvar o ranking.';
      return false;
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }
}
