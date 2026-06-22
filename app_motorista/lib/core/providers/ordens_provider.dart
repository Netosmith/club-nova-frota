import 'package:flutter/material.dart';

import '../../shared/models/ordem_model.dart';
import '../repositories/ordens_repository.dart';

class OrdensProvider extends ChangeNotifier {
  OrdensProvider({OrdensRepository? ordensRepository})
      : _ordensRepository = ordensRepository ?? OrdensRepository();

  final OrdensRepository _ordensRepository;

  List<OrdemModel> _ordens = [];
  bool _carregando = false;
  String? _erro;

  List<OrdemModel> get ordens => _ordens;
  bool get carregando => _carregando;
  String? get erro => _erro;

  void acompanharOrdensDoMotorista(String motoristaId) {
    _carregando = true;
    notifyListeners();

    _ordensRepository.listarDoMotorista(motoristaId).listen(
      (lista) {
        _ordens = lista;
        _carregando = false;
        _erro = null;
        notifyListeners();
      },
      onError: (_) {
        _erro = 'Não foi possível carregar as ordens.';
        _carregando = false;
        notifyListeners();
      },
    );
  }

  Future<bool> solicitarOrdem({
    required String motoristaId,
    required String freteId,
  }) async {
    _carregando = true;
    _erro = null;
    notifyListeners();

    try {
      await _ordensRepository.solicitarOrdem(
        motoristaId: motoristaId,
        freteId: freteId,
      );
      return true;
    } catch (_) {
      _erro = 'Não foi possível solicitar a ordem.';
      return false;
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }
}
