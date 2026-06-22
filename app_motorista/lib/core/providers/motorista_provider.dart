import 'package:flutter/material.dart';

import '../../shared/models/motorista_model.dart';
import '../repositories/motoristas_repository.dart';

class MotoristaProvider extends ChangeNotifier {
  MotoristaProvider({MotoristasRepository? motoristasRepository})
      : _motoristasRepository = motoristasRepository ?? MotoristasRepository();

  final MotoristasRepository _motoristasRepository;

  MotoristaModel? _motorista;
  bool _carregando = false;
  String? _erro;

  MotoristaModel? get motorista => _motorista;
  bool get carregando => _carregando;
  String? get erro => _erro;

  Future<void> carregarMotorista(String motoristaId) async {
    _carregando = true;
    _erro = null;
    notifyListeners();

    try {
      _motorista = await _motoristasRepository.buscarMotorista(motoristaId);
    } catch (_) {
      _erro = 'Não foi possível carregar os dados do motorista.';
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }
}
