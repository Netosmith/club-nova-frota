import 'package:cloud_firestore/cloud_firestore.dart';

import '../../shared/models/chamado_admin_model.dart';
import 'admin_firestore_service.dart';

class AdminChamadosService {
  AdminChamadosService({AdminFirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? AdminFirestoreService();

  final AdminFirestoreService _firestoreService;
  static const String _collection = 'chamados';

  Stream<List<ChamadoAdminModel>> listarChamados() {
    return _firestoreService
        .collection(_collection)
        .snapshots()
        .map(_mapChamados);
  }

  Future<void> atualizarStatus({
    required String chamadoId,
    required String status,
    required String responsavel,
  }) {
    return _firestoreService.updateDocument(
      collectionPath: _collection,
      documentId: chamadoId,
      data: {
        'status': status,
        'responsavel': responsavel,
        'atualizadoEm': FieldValue.serverTimestamp(),
      },
    );
  }

  List<ChamadoAdminModel> _mapChamados(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    return snapshot.docs
        .map((doc) => ChamadoAdminModel.fromMap(doc.id, doc.data()))
        .toList();
  }
}
