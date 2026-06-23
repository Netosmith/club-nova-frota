import 'package:cloud_firestore/cloud_firestore.dart';

import '../../shared/models/ordem_admin_model.dart';
import '../constants/admin_firestore_collections.dart';
import 'admin_firestore_service.dart';

class AdminOrdensService {
  AdminOrdensService({AdminFirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? AdminFirestoreService();

  final AdminFirestoreService _firestoreService;

  Stream<List<OrdemAdminModel>> listarOrdens() {
    return _firestoreService
        .collection(AdminFirestoreCollections.ordens)
        .orderBy('atualizadoEm', descending: true)
        .snapshots()
        .map(_mapOrdens);
  }

  Future<void> atualizarStatus({
    required String ordemId,
    required String status,
  }) {
    return _firestoreService.updateDocument(
      collectionPath: AdminFirestoreCollections.ordens,
      documentId: ordemId,
      data: {
        'status': status,
        'atualizadoEm': FieldValue.serverTimestamp(),
      },
    );
  }

  Future<void> aprovarOrdem(String ordemId) {
    return atualizarStatus(ordemId: ordemId, status: 'liberada');
  }

  Future<void> rejeitarOrdem(String ordemId) {
    return atualizarStatus(ordemId: ordemId, status: 'negada');
  }

  List<OrdemAdminModel> _mapOrdens(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs
        .map((doc) => OrdemAdminModel.fromMap(doc.id, doc.data()))
        .toList();
  }
}
