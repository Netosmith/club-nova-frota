import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../repositories/admin_auth_repository.dart';

class AdminAuthProvider extends ChangeNotifier {
  AdminAuthProvider({AdminAuthRepository? authRepository})
      : _authRepository = authRepository ?? AdminAuthRepository();

  final AdminAuthRepository _authRepository;

  User? _usuario;
  bool _carregando = false;
  String? _erro;

  User? get usuario => _usuario;
  bool get autenticado => _usuario != null;
  bool get carregando => _carregando;
  String? get erro => _erro;

  void iniciar() {
    _usuario = _authRepository.usuarioAtual;
    notifyListeners();

    _authRepository.acompanharUsuario().listen((usuario) {
      _usuario = usuario;
      notifyListeners();
    });
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
      return true;
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
    notifyListeners();
  }
}
