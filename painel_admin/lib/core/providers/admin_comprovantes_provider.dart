import 'package:flutter/material.dart';

import '../../shared/models/comprovante_admin_model.dart';
import '../repositories/admin_comprovantes_repository.dart';

class AdminComprovantesProvider extends ChangeNotifier {
  AdminComprovantesProvider({
    AdminComprovantesRepository? comprovantesRepository,
  }) : _comprovantesRepository =
            comprovantesRepository ?? AdminComprovantesRepository();

  final AdminComprovantesRepository _comprovantesRepository;

  List<ComprovanteAdminModel> _comprovantes = [];
  bool _carregando = false;
  String? _erro;

  List<ComprovanteAdminModel> get comprovantes => _comprovantes;
  bool get carregando => _carregando;
  String? get erro => _erro;

  void acompanharComprovantes() {
    _carregando = true;
    notifyListeners();

    _comprovantesRepository.listarComprovantes().listen(
      (lista) {
        _comprovantes = lista;
        _carregando = false;
        _erro = null;
        notifyListeners();
      },
      onError: (_) {
        _erro = 'Não foi possível carregar os comprovantes.';
        _carregando = false;
        notifyListeners();
      },
    );
  }

  Future<bool> aprovarComprovante({
    required String comprovanteId,
    required String analisadoPor,
  }) async {
    return _executar(
      () => _comprovantesRepository.aprovarComprovante(
        comprovanteId: comprovanteId,
        analisadoPor: analisadoPor,
      ),
    );
  }

  Future<bool> rejeitarComprovante({
    required String comprovanteId,
    required String analisadoPor,
  }) async {
    return _executar(
      () => _comprovantesRepository.rejeitarComprovante(
        comprovanteId: comprovanteId,
        analisadoPor: analisadoPor,
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
