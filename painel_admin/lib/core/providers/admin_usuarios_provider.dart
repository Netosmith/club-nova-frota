import 'package:flutter/material.dart';

import '../../shared/models/usuario_admin_model.dart';
import '../repositories/admin_usuarios_repository.dart';

class AdminUsuariosProvider extends ChangeNotifier {
  AdminUsuariosProvider({AdminUsuariosRepository? usuariosRepository})
      : _usuariosRepository = usuariosRepository ?? AdminUsuariosRepository();

  final AdminUsuariosRepository _usuariosRepository;

  List<UsuarioAdminModel> _usuarios = [];
  bool _carregando = false;
  String? _erro;

  List<UsuarioAdminModel> get usuarios => _usuarios;
  bool get carregando => _carregando;
  String? get erro => _erro;

  void acompanharUsuarios() {
    _carregando = true;
    notifyListeners();

    _usuariosRepository.listarUsuarios().listen(
      (lista) {
        _usuarios = lista;
        _carregando = false;
        _erro = null;
        notifyListeners();
      },
      onError: (_) {
        _erro = 'Não foi possível carregar os usuários do painel.';
        _carregando = false;
        notifyListeners();
      },
    );
  }

  Future<bool> salvarUsuario(UsuarioAdminModel usuario) async {
    return _executar(() => _usuariosRepository.salvarUsuario(usuario));
  }

  Future<bool> ativarUsuario(String usuarioId) async {
    return _executar(() => _usuariosRepository.ativarUsuario(usuarioId));
  }

  Future<bool> bloquearUsuario(String usuarioId) async {
    return _executar(() => _usuariosRepository.bloquearUsuario(usuarioId));
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
