import 'package:cloud_firestore/cloud_firestore.dart';

import '../../shared/models/notificacao_admin_model.dart';
import 'admin_firestore_service.dart';

class AdminNotificacoesService {
  AdminNotificacoesService({AdminFirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? AdminFirestoreService();

  final AdminFirestoreService _firestoreService;
  static const String _collection = 'notificacoes';

  Stream<List<NotificacaoAdminModel>> listarNotificacoes() {
    return _firestoreService
        .collection(_collection)
        .snapshots()
        .map(_mapNotificacoes);
  }

  Future<void> salvarNotificacao(NotificacaoAdminModel notificacao) {
    return _firestoreService.setDocument(
      collectionPath: _collection,
      documentId: notificacao.id,
      data: {
        ...notificacao.toMap(),
        'criadoEm': FieldValue.serverTimestamp(),
      },
    );
  }

  Future<void> atualizarStatus({
    required String notificacaoId,
    required String status,
  }) {
    return _firestoreService.updateDocument(
      collectionPath: _collection,
      documentId: notificacaoId,
      data: {
        'status': status,
        'atualizadoEm': FieldValue.serverTimestamp(),
      },
    );
  }

  List<NotificacaoAdminModel> _mapNotificacoes(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    return snapshot.docs
        .map((doc) => NotificacaoAdminModel.fromMap(doc.id, doc.data()))
        .toList();
  }
}
