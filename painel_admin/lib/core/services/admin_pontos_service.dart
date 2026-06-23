import 'package:cloud_firestore/cloud_firestore.dart';

import '../../shared/models/pontos_admin_model.dart';
import '../constants/admin_firestore_collections.dart';
import 'admin_firestore_service.dart';

class AdminPontosService {
  AdminPontosService({AdminFirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? AdminFirestoreService();

  final AdminFirestoreService _firestoreService;

  Stream<List<PontosAdminModel>> listarPontos() {
    return _firestoreService
        .collection(AdminFirestoreCollections.pontos)
        .orderBy('criadoEm', descending: true)
        .snapshots()
        .map(_mapPontos);
  }

  Future<void> salvarMovimentacao(PontosAdminModel pontos) {
    return _firestoreService.setDocument(
      collectionPath: AdminFirestoreCollections.pontos,
      documentId: pontos.id,
      data: {
        ...pontos.toMap(),
        'criadoEm': FieldValue.serverTimestamp(),
      },
    );
  }

  List<PontosAdminModel> _mapPontos(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs
        .map((doc) => PontosAdminModel.fromMap(doc.id, doc.data()))
        .toList();
  }
}
