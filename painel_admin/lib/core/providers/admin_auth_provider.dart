import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../repositories/admin_auth_repository.dart';

class AdminAuthProvider extends ChangeNotifier {
  AdminAuthProvider({AdminAuthRepository? authRepository})
      : _authRepository = authRepository ?? AdminAuthRepository();

  final AdminAuthRepository _authRepository;

  User? _usuario;
  String? _perfil;
  bool _ativo = false;
  bool _carregando = false;
  String? _erro;

  static const List<String> _perfisPermitidos = [
    'admin',
    'coordenador',
    'operacional',
    'comercial',
    'financeiro',
  ];

  User? get usuario => _usuario;
  String? get perfil => _perfil;
  bool get ativo => _ativo;
  bool get autenticado => _usuario != null && _ativo && _perfilAutorizado;
  bool get carregando => _carregando;
  String? get erro => _erro;

  bool get _perfilAutorizado {
    return _perfil != null && _perfisPermitidos.contains(_perfil);
  }

  void iniciar() {
    _usuario = _authRepository.usuarioAtual;
    if (_usuario != null) {
      validarPerfilAtual();
    }

    _authRepository.acompanharUsuario().listen((usuario) {
      _usuario = usuario;
      if (usuario == null) {
        _perfil = null;
        _ativo = false;
        notifyListeners();
        return;
      }
      validarPerfilAtual();
    });
  }

  Future<void> validarPerfilAtual() async {
    final usuarioAtual = _usuario;
    if (usuarioAtual == null) return;

    try {
      final perfilUsuario = await _authRepository.buscarPerfilUsuario(usuarioAtual.uid);
      _perfil = perfilUsuario?['perfil'];
      _ativo = perfilUsuario?['ativo'] == true;

      if (!_ativo || !_perfilAutorizado) {
        _erro = 'Usuário sem permissão administrativa.';
        await _authRepository.sair();
        _usuario = null;
        _perfil = null;
        _ativo = false;
      } else {
        _erro = null;
      }
    } catch (_) {
      _erro = 'Não foi possível validar o perfil administrativo.';
      await _authRepository.sair();
      _usuario = null;
      _perfil = null;
      _ativo = false;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> entrar({
    required String email,
    required String senha,
  }) async {
    _carregando = true;
    _erro = null;
    notifyListeners();

    try {
      final credencial = await _authRepository.entrar(
        email: email,
        senha: senha,
      );
      _usuario = credencial.user;
      await validarPerfilAtual();
      return autenticado;
    } catch (_) {
      _erro = 'Não foi possível acessar o painel.';
      return false;
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }

  Future<void> sair() async {
    await _authRepository.sair();
    _usuario = null;
    _perfil = null;
    _ativo = false;
    notifyListeners();
  }
}
