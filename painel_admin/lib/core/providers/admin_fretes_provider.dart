import 'package:flutter/material.dart';

import '../../shared/models/frete_admin_model.dart';
import '../repositories/admin_fretes_repository.dart';

class AdminFretesProvider extends ChangeNotifier {
  AdminFretesProvider({AdminFretesRepository? fretesRepository})
      : _fretesRepository = fretesRepository ?? AdminFretesRepository();

  final AdminFretesRepository _fretesRepository;

  List<FreteAdminModel> _fretes = [];
  bool _carregando = false;
  String? _erro;

  List<FreteAdminModel> get fretes => _fretes;
  bool get carregando => _carregando;
  String? get erro => _erro;

  void acompanharFretes() {
    _carregando = true;
    notifyListeners();

    _fretesRepository.listarFretes().listen(
      (lista) {
        _fretes = lista;
        _carregando = false;
        _erro = null;
        notifyListeners();
      },
      onError: (_) {
        _erro = 'Não foi possível carregar os fretes.';
        _carregando = false;
        notifyListeners();
      },
    );
  }

  Future<bool> salvarFrete(FreteAdminModel frete) async {
    return _executar(() => _fretesRepository.salvarFrete(frete));
  }

  Future<bool> liberarFrete(String freteId) async {
    return _executar(() => _fretesRepository.liberarFrete(freteId));
  }

  Future<bool> encerrarFrete(String freteId) async {
    return _executar(() => _fretesRepository.encerrarFrete(freteId));
  }

  Future<bool> cancelarFrete(String freteId) async {
    return _executar(() => _fretesRepository.cancelarFrete(freteId));
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
