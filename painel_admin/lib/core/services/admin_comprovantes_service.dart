import 'package:cloud_firestore/cloud_firestore.dart';

import '../../shared/models/comprovante_admin_model.dart';
import '../constants/admin_firestore_collections.dart';
import 'admin_firestore_service.dart';

class AdminComprovantesService {
  AdminComprovantesService({AdminFirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? AdminFirestoreService();

  final AdminFirestoreService _firestoreService;

  Stream<List<ComprovanteAdminModel>> listarComprovantes() {
    return _firestoreService
        .collection(AdminFirestoreCollections.comprovantes)
        .orderBy('enviadoEm', descending: true)
        .snapshots()
        .map(_mapComprovantes);
  }

  Future<void> atualizarStatus({
    required String comprovanteId,
    required String status,
    required String analisadoPor,
  }) {
    return _firestoreService.updateDocument(
      collectionPath: AdminFirestoreCollections.comprovantes,
      documentId: comprovanteId,
      data: {
        'status': status,
        'analisadoPor': analisadoPor,
        'analisadoEm': FieldValue.serverTimestamp(),
        'atualizadoEm': FieldValue.serverTimestamp(),
      },
    );
  }

  Future<void> aprovarComprovante({
    required String comprovanteId,
    required String analisadoPor,
  }) {
    return atualizarStatus(
      comprovanteId: comprovanteId,
      status: 'aprovado',
      analisadoPor: analisadoPor,
    );
  }

  Future<void> rejeitarComprovante({
    required String comprovanteId,
    required String analisadoPor,
  }) {
    return atualizarStatus(
      comprovanteId: comprovanteId,
      status: 'rejeitado',
      analisadoPor: analisadoPor,
    );
  }

  List<ComprovanteAdminModel> _mapComprovantes(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    return snapshot.docs
        .map((doc) => ComprovanteAdminModel.fromMap(doc.id, doc.data()))
        .toList();
  }
}
