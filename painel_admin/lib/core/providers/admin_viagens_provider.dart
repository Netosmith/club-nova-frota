import 'package:flutter/material.dart';

import '../../shared/models/viagem_admin_model.dart';
import '../services/admin_viagens_service.dart';

class AdminViagensProvider extends ChangeNotifier {
  AdminViagensProvider({AdminViagensService? service})
      : _service = service ?? AdminViagensService();

  final AdminViagensService _service;

  List<ViagemAdminModel> _viagens = [];
  bool _carregando = false;
  String? _erro;

  List<ViagemAdminModel> get viagens => _viagens;
  bool get carregando => _carregando;
  String? get erro => _erro;

  int get emViagem => _viagens.where((item) => item.status == 'em_viagem').length;
  int get aguardandoCarga => _viagens.where((item) => item.status == 'aguardando_carga').length;
  int get finalizadas => _viagens.where((item) => item.status == 'finalizada').length;

  void acompanharViagens() {
    _carregando = true;
    notifyListeners();

    _service.listarViagens().listen(
      (lista) {
        _viagens = lista;
        _carregando = false;
        _erro = null;
        notifyListeners();
      },
      onError: (_) {
        _erro = 'Não foi possível carregar as viagens.';
        _carregando = false;
        notifyListeners();
      },
    );
  }

  Future<bool> atualizarStatus({
    required String viagemId,
    required String status,
  }) async {
    _carregando = true;
    _erro = null;
    notifyListeners();

    try {
      await _service.atualizarStatus(viagemId: viagemId, status: status);
      return true;
    } catch (_) {
      _erro = 'Não foi possível atualizar a viagem.';
      return false;
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }
}
