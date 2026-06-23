import 'package:cloud_firestore/cloud_firestore.dart';

import '../../shared/models/frete_admin_model.dart';
import '../constants/admin_firestore_collections.dart';
import 'admin_firestore_service.dart';

class AdminFretesService {
  AdminFretesService({AdminFirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? AdminFirestoreService();

  final AdminFirestoreService _firestoreService;

  Stream<List<FreteAdminModel>> listarFretes() {
    return _firestoreService
        .collection(AdminFirestoreCollections.fretes)
        .orderBy('atualizadoEm', descending: true)
        .snapshots()
        .map(_mapFretes);
  }

  Future<void> salvarFrete(FreteAdminModel frete) {
    return _firestoreService.setDocument(
      collectionPath: AdminFirestoreCollections.fretes,
      documentId: frete.id,
      data: {
        ...frete.toMap(),
        'atualizadoEm': FieldValue.serverTimestamp(),
      },
    );
  }

  Future<void> atualizarStatus({
    required String freteId,
    required String status,
  }) {
    return _firestoreService.updateDocument(
      collectionPath: AdminFirestoreCollections.fretes,
      documentId: freteId,
      data: {
        'status': status,
        'atualizadoEm': FieldValue.serverTimestamp(),
      },
    );
  }

  List<FreteAdminModel> _mapFretes(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs
        .map((doc) => FreteAdminModel.fromMap(doc.id, doc.data()))
        .toList();
  }
}
