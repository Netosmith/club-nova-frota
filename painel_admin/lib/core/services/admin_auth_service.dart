import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminAuthService {
  AdminAuthService({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

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

  Future<Map<String, dynamic>?> buscarPerfilUsuario(String usuarioId) async {
    final documento = await _firestore.collection('usuarios').doc(usuarioId).get();
    return documento.data();
  }

  Future<void> sair() {
    return _firebaseAuth.signOut();
  }
}
