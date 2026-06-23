import 'package:firebase_auth/firebase_auth.dart';

import '../services/admin_auth_service.dart';

class AdminAuthRepository {
  AdminAuthRepository({AdminAuthService? authService})
      : _authService = authService ?? AdminAuthService();

  final AdminAuthService _authService;

  User? get usuarioAtual => _authService.usuarioAtual;

  Stream<User?> acompanharUsuario() {
    return _authService.acompanharUsuario();
  }

  Future<UserCredential> entrar({
    required String email,
    required String senha,
  }) {
    return _authService.entrarComEmailSenha(
      email: email,
      senha: senha,
    );
  }

  Future<void> sair() {
    return _authService.sair();
  }
}
