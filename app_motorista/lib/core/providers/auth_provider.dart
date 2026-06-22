import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider({AuthRepository? authRepository})
      : _authRepository = authRepository ?? AuthRepository();

  final AuthRepository _authRepository;

  User? _usuario;
  bool _carregando = false;
  String? _erro;

  User? get usuario => _usuario;
  bool get carregando => _carregando;
  String? get erro => _erro;
  bool get autenticado => _usuario != null;

  void iniciar() {
    _usuario = _authRepository.usuarioAtual;
    _authRepository.acompanharAutenticacao.listen((user) {
      _usuario = user;
      notifyListeners();
    });
  }

  Future<bool> entrarComEmailSenha({
    required String email,
    required String senha,
  }) async {
    return _executar(() async {
      final result = await _authRepository.entrarComEmailSenha(
        email: email,
        senha: senha,
      );
      _usuario = result.user;
      return _usuario != null;
    });
  }

  Future<bool> entrarComGoogle() async {
    return _executar(() async {
      final result = await _authRepository.entrarComGoogle();
      _usuario = result?.user;
      return _usuario != null;
    });
  }

  Future<void> recuperarSenha(String email) {
    return _authRepository.recuperarSenha(email);
  }

  Future<void> sair() async {
    await _authRepository.sair();
    _usuario = null;
    notifyListeners();
  }

  Future<bool> _executar(Future<bool> Function() action) async {
    _carregando = true;
    _erro = null;
    notifyListeners();

    try {
      return await action();
    } catch (_) {
      _erro = 'Não foi possível autenticar.';
      return false;
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }
}
