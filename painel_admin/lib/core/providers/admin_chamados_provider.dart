import 'package:flutter/material.dart';

import '../../shared/models/chamado_admin_model.dart';
import '../services/admin_chamados_service.dart';

class AdminChamadosProvider extends ChangeNotifier {
  AdminChamadosProvider({AdminChamadosService? service})
      : _service = service ?? AdminChamadosService();

  final AdminChamadosService _service;

  List<ChamadoAdminModel> _chamados = [];
  bool _carregando = false;
  String? _erro;

  List<ChamadoAdminModel> get chamados => _chamados;
  bool get carregando => _carregando;
  String? get erro => _erro;

  int get abertos => _chamados.where((item) => item.status == 'aberto').length;
  int get emAtendimento => _chamados.where((item) => item.status == 'em_atendimento').length;
  int get finalizados => _chamados.where((item) => item.status == 'finalizado').length;

  void acompanharChamados() {
    _carregando = true;
    notifyListeners();

    _service.listarChamados().listen(
      (lista) {
        _chamados = lista;
        _carregando = false;
        _erro = null;
        notifyListeners();
      },
      onError: (_) {
        _erro = 'Não foi possível carregar os chamados.';
        _carregando = false;
        notifyListeners();
      },
    );
  }

  Future<bool> atualizarStatus({
    required String chamadoId,
    required String status,
    required String responsavel,
  }) async {
    _carregando = true;
    _erro = null;
    notifyListeners();

    try {
      await _service.atualizarStatus(
        chamadoId: chamadoId,
        status: status,
        responsavel: responsavel,
      );
      return true;
    } catch (_) {
      _erro = 'Não foi possível atualizar o chamado.';
      return false;
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }
}
