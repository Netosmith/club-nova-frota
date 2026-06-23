import 'package:flutter/material.dart';

import '../../shared/models/pontos_admin_model.dart';
import '../repositories/admin_pontos_repository.dart';

class AdminPontosProvider extends ChangeNotifier {
  AdminPontosProvider({AdminPontosRepository? pontosRepository})
      : _pontosRepository = pontosRepository ?? AdminPontosRepository();

  final AdminPontosRepository _pontosRepository;

  List<PontosAdminModel> _movimentacoes = [];
  bool _carregando = false;
  String? _erro;

  List<PontosAdminModel> get movimentacoes => _movimentacoes;
  bool get carregando => _carregando;
  String? get erro => _erro;

  int get creditosTotais {
    return _movimentacoes
        .where((item) => item.tipo == 'credito' || item.tipo == 'bonus' || item.tipo == 'indicacao')
        .fold<int>(0, (total, item) => total + item.pontos);
  }

  int get debitosTotais {
    return _movimentacoes
        .where((item) => item.tipo == 'debito' || item.tipo == 'resgate')
        .fold<int>(0, (total, item) => total + item.pontos.abs());
  }

  int get saldoMovimentado => creditosTotais - debitosTotais;

  void acompanharPontos() {
    _carregando = true;
    notifyListeners();

    _pontosRepository.listarPontos().listen(
      (lista) {
        _movimentacoes = lista;
        _carregando = false;
        _erro = null;
        notifyListeners();
      },
      onError: (_) {
        _erro = 'Não foi possível carregar os pontos.';
        _carregando = false;
        notifyListeners();
      },
    );
  }

  Future<bool> salvarMovimentacao(PontosAdminModel pontos) async {
    _carregando = true;
    _erro = null;
    notifyListeners();

    try {
      await _pontosRepository.salvarMovimentacao(pontos);
      return true;
    } catch (_) {
      _erro = 'Não foi possível salvar a movimentação.';
      return false;
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }
}
