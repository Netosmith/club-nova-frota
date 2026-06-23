import 'package:firebase_auth/firebase_auth.dart';

class AdminAuthService {
  AdminAuthService({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  User? get usuarioAtual => _firebaseAuth.currentUser;

  Stream<User?> acompanharUsuario() {
    return _firebaseAuth.authStateChanges();
  }

  Future<UserCredential> entrarComEmailSenha({
    required String email,
    required String senha,
  }) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: senha,
    );
  }

  Future<void> sair() {
    return _firebaseAuth.signOut();
  }
}
