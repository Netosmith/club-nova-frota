import 'package:flutter/material.dart';

import '../../shared/models/notificacao_admin_model.dart';
import '../services/admin_notificacoes_service.dart';

class AdminNotificacoesProvider extends ChangeNotifier {
  AdminNotificacoesProvider({AdminNotificacoesService? service})
      : _service = service ?? AdminNotificacoesService();

  final AdminNotificacoesService _service;

  List<NotificacaoAdminModel> _notificacoes = [];
  bool _carregando = false;
  String? _erro;

  List<NotificacaoAdminModel> get notificacoes => _notificacoes;
  bool get carregando => _carregando;
  String? get erro => _erro;

  int get rascunhos => _notificacoes.where((item) => item.status == 'rascunho').length;
  int get enviadas => _notificacoes.where((item) => item.status == 'enviada').length;

  void acompanharNotificacoes() {
    _carregando = true;
    notifyListeners();

    _service.listarNotificacoes().listen(
      (lista) {
        _notificacoes = lista;
        _carregando = false;
        _erro = null;
        notifyListeners();
      },
      onError: (_) {
        _erro = 'Não foi possível carregar as notificações.';
        _carregando = false;
        notifyListeners();
      },
    );
  }

  Future<bool> salvar(NotificacaoAdminModel notificacao) async {
    return _executar(() => _service.salvarNotificacao(notificacao));
  }

  Future<bool> enviar(String notificacaoId) async {
    return _executar(
      () => _service.atualizarStatus(
        notificacaoId: notificacaoId,
        status: 'enviada',
      ),
    );
  }

  Future<bool> cancelar(String notificacaoId) async {
    return _executar(
      () => _service.atualizarStatus(
        notificacaoId: notificacaoId,
        status: 'cancelada',
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
