import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth_service.dart';

class AuthRepository {
  AuthRepository({AuthService? authService})
      : _authService = authService ?? AuthService();

  final AuthService _authService;

  User? get usuarioAtual => _authService.usuarioAtual;

  Stream<User?> get acompanharAutenticacao => _authService.authStateChanges;

  Future<UserCredential> entrarComEmailSenha({
    required String email,
    required String senha,
  }) {
    return _authService.entrarComEmailSenha(email: email, senha: senha);
  }

  Future<UserCredential?> entrarComGoogle() {
    return _authService.entrarComGoogle();
  }

  Future<void> recuperarSenha(String email) {
    return _authService.enviarRecuperacaoSenha(email);
  }

  Future<void> sair() {
    return _authService.sair();
  }
}
