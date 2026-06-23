import 'package:flutter/material.dart';

import '../../shared/models/motorista_admin_model.dart';
import '../repositories/admin_motoristas_repository.dart';

class AdminMotoristasProvider extends ChangeNotifier {
  AdminMotoristasProvider({AdminMotoristasRepository? motoristasRepository})
      : _motoristasRepository =
            motoristasRepository ?? AdminMotoristasRepository();

  final AdminMotoristasRepository _motoristasRepository;

  List<MotoristaAdminModel> _motoristas = [];
  bool _carregando = false;
  String? _erro;

  List<MotoristaAdminModel> get motoristas => _motoristas;
  bool get carregando => _carregando;
  String? get erro => _erro;

  void acompanharMotoristas() {
    _carregando = true;
    notifyListeners();

    _motoristasRepository.listarMotoristas().listen(
      (lista) {
        _motoristas = lista;
        _carregando = false;
        _erro = null;
        notifyListeners();
      },
      onError: (_) {
        _erro = 'Não foi possível carregar os motoristas.';
        _carregando = false;
        notifyListeners();
      },
    );
  }

  Future<bool> salvarMotorista(MotoristaAdminModel motorista) async {
    return _executar(() => _motoristasRepository.salvarMotorista(motorista));
  }

  Future<bool> ativarMotorista(String motoristaId) async {
    return _executar(() => _motoristasRepository.ativarMotorista(motoristaId));
  }

  Future<bool> bloquearMotorista(String motoristaId) async {
    return _executar(() => _motoristasRepository.bloquearMotorista(motoristaId));
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
