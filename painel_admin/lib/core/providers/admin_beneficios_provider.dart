import 'package:flutter/material.dart';

import '../../shared/models/beneficio_admin_model.dart';
import '../repositories/admin_beneficios_repository.dart';

class AdminBeneficiosProvider extends ChangeNotifier {
  AdminBeneficiosProvider({AdminBeneficiosRepository? beneficiosRepository})
      : _beneficiosRepository =
            beneficiosRepository ?? AdminBeneficiosRepository();

  final AdminBeneficiosRepository _beneficiosRepository;

  List<BeneficioAdminModel> _beneficios = [];
  bool _carregando = false;
  String? _erro;

  List<BeneficioAdminModel> get beneficios => _beneficios;
  bool get carregando => _carregando;
  String? get erro => _erro;

  int get beneficiosAtivos {
    return _beneficios.where((beneficio) => beneficio.ativo).length;
  }

  int get estoqueTotal {
    return _beneficios.fold<int>(0, (total, item) => total + item.estoque);
  }

  void acompanharBeneficios() {
    _carregando = true;
    notifyListeners();

    _beneficiosRepository.listarBeneficios().listen(
      (lista) {
        _beneficios = lista;
        _carregando = false;
        _erro = null;
        notifyListeners();
      },
      onError: (_) {
        _erro = 'Não foi possível carregar os benefícios.';
        _carregando = false;
        notifyListeners();
      },
    );
  }

  Future<bool> salvarBeneficio(BeneficioAdminModel beneficio) async {
    return _executar(() => _beneficiosRepository.salvarBeneficio(beneficio));
  }

  Future<bool> ativarBeneficio(String beneficioId) async {
    return _executar(() => _beneficiosRepository.ativarBeneficio(beneficioId));
  }

  Future<bool> inativarBeneficio(String beneficioId) async {
    return _executar(() => _beneficiosRepository.inativarBeneficio(beneficioId));
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
