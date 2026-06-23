import 'package:flutter/material.dart';

import '../../shared/models/ordem_admin_model.dart';
import '../repositories/admin_ordens_repository.dart';

class AdminOrdensProvider extends ChangeNotifier {
  AdminOrdensProvider({AdminOrdensRepository? ordensRepository})
      : _ordensRepository = ordensRepository ?? AdminOrdensRepository();

  final AdminOrdensRepository _ordensRepository;

  List<OrdemAdminModel> _ordens = [];
  bool _carregando = false;
  String? _erro;

  List<OrdemAdminModel> get ordens => _ordens;
  bool get carregando => _carregando;
  String? get erro => _erro;

  void acompanharOrdens() {
    _carregando = true;
    notifyListeners();

    _ordensRepository.listarOrdens().listen(
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

  Future<bool> aprovarOrdem(String ordemId) async {
    return _executar(() => _ordensRepository.aprovarOrdem(ordemId));
  }

  Future<bool> rejeitarOrdem(String ordemId) async {
    return _executar(() => _ordensRepository.rejeitarOrdem(ordemId));
  }

  Future<bool> atualizarStatus({
    required String ordemId,
    required String status,
  }) async {
    return _executar(
      () => _ordensRepository.atualizarStatus(
        ordemId: ordemId,
        status: status,
      ),
    );
  }

  Future<bool> _executar(Future<void> Function() action) async {
    _carregando = true;
    _erro = null;
    notifyListeners();

    try {
      await action();
      return true;
    } catch (_) {
      _erro = 'Não foi possível concluir a ação.';
      return false;
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }
}
