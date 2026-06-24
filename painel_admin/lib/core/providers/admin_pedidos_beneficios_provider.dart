import 'package:flutter/material.dart';

import '../../shared/models/pedido_beneficio_admin_model.dart';
import '../services/admin_pedidos_beneficios_service.dart';

class AdminPedidosBeneficiosProvider extends ChangeNotifier {
  AdminPedidosBeneficiosProvider({AdminPedidosBeneficiosService? service})
      : _service = service ?? AdminPedidosBeneficiosService();

  final AdminPedidosBeneficiosService _service;

  List<PedidoBeneficioAdminModel> _pedidos = [];
  bool _carregando = false;
  String? _erro;

  List<PedidoBeneficioAdminModel> get pedidos => _pedidos;
  bool get carregando => _carregando;
  String? get erro => _erro;

  int get novos => _pedidos.where((item) => item.situacao == 'novo').length;
  int get aprovados => _pedidos.where((item) => item.situacao == 'aprovado').length;
  int get entregues => _pedidos.where((item) => item.situacao == 'entregue').length;

  void acompanharPedidos() {
    _carregando = true;
    notifyListeners();

    _service.listarPedidos().listen(
      (lista) {
        _pedidos = lista;
        _carregando = false;
        _erro = null;
        notifyListeners();
      },
      onError: (_) {
        _erro = 'Não foi possível carregar os pedidos.';
        _carregando = false;
        notifyListeners();
      },
    );
  }

  Future<bool> atualizarSituacao({
    required String pedidoId,
    required String situacao,
  }) async {
    _carregando = true;
    _erro = null;
    notifyListeners();

    try {
      await _service.atualizarSituacao(
        pedidoId: pedidoId,
        situacao: situacao,
      );
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
