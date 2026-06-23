import 'package:cloud_firestore/cloud_firestore.dart';

import '../../shared/models/usuario_admin_model.dart';
import '../constants/admin_firestore_collections.dart';
import 'admin_firestore_service.dart';

class AdminUsuariosService {
  AdminUsuariosService({AdminFirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? AdminFirestoreService();

  final AdminFirestoreService _firestoreService;

  Stream<List<UsuarioAdminModel>> listarUsuarios() {
    return _firestoreService
        .collection(AdminFirestoreCollections.usuarios)
        .orderBy('nome')
        .snapshots()
        .map(_mapUsuarios);
  }

  Future<void> salvarUsuario(UsuarioAdminModel usuario) {
    return _firestoreService.setDocument(
      collectionPath: AdminFirestoreCollections.usuarios,
      documentId: usuario.id,
      data: {
        ...usuario.toMap(),
        'atualizadoEm': FieldValue.serverTimestamp(),
      },
    );
  }

  Future<void> atualizarStatus({
    required String usuarioId,
    required bool ativo,
  }) {
    return _firestoreService.updateDocument(
      collectionPath: AdminFirestoreCollections.usuarios,
      documentId: usuarioId,
      data: {
        'ativo': ativo,
        'atualizadoEm': FieldValue.serverTimestamp(),
      },
    );
  }

  List<UsuarioAdminModel> _mapUsuarios(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs
        .map((doc) => UsuarioAdminModel.fromMap(doc.id, doc.data()))
        .toList();
  }
}
