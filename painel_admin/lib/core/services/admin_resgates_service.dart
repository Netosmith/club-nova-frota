import 'package:cloud_firestore/cloud_firestore.dart';

import '../../shared/models/resgate_admin_model.dart';
import '../constants/admin_firestore_collections.dart';
import 'admin_firestore_service.dart';

class AdminResgatesService {
  AdminResgatesService({AdminFirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? AdminFirestoreService();

  final AdminFirestoreService _firestoreService;

  Stream<List<ResgateAdminModel>> listarResgates() {
    return _firestoreService
        .collection(AdminFirestoreCollections.resgates)
        .snapshots()
        .map(_mapResgates);
  }

  Future<void> atualizarStatus({
    required String resgateId,
    required String status,
  }) {
    return _firestoreService.updateDocument(
      collectionPath: AdminFirestoreCollections.resgates,
      documentId: resgateId,
      data: {
        'status': status,
        'atualizadoEm': FieldValue.serverTimestamp(),
      },
    );
  }

  List<ResgateAdminModel> _mapResgates(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    return snapshot.docs
        .map((doc) => ResgateAdminModel.fromMap(doc.id, doc.data()))
        .toList();
  }
}
