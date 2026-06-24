import 'package:cloud_firestore/cloud_firestore.dart';

import '../../shared/models/viagem_admin_model.dart';
import 'admin_firestore_service.dart';

class AdminViagensService {
  AdminViagensService({AdminFirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? AdminFirestoreService();

  final AdminFirestoreService _firestoreService;
  static const String _collection = 'viagens';

  Stream<List<ViagemAdminModel>> listarViagens() {
    return _firestoreService
        .collection(_collection)
        .snapshots()
        .map(_mapViagens);
  }

  Future<void> atualizarStatus({
    required String viagemId,
    required String status,
  }) {
    return _firestoreService.updateDocument(
      collectionPath: _collection,
      documentId: viagemId,
      data: {
        'status': status,
        'atualizadoEm': FieldValue.serverTimestamp(),
      },
    );
  }

  List<ViagemAdminModel> _mapViagens(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    return snapshot.docs
        .map((doc) => ViagemAdminModel.fromMap(doc.id, doc.data()))
        .toList();
  }
}
