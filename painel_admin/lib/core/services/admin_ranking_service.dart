import 'package:cloud_firestore/cloud_firestore.dart';

import '../../shared/models/ranking_admin_model.dart';
import '../constants/admin_firestore_collections.dart';
import 'admin_firestore_service.dart';

class AdminRankingService {
  AdminRankingService({AdminFirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? AdminFirestoreService();

  final AdminFirestoreService _firestoreService;

  Stream<List<RankingAdminModel>> listarRanking() {
    return _firestoreService
        .collection(AdminFirestoreCollections.ranking)
        .orderBy('pontos', descending: true)
        .snapshots()
        .map(_mapRanking);
  }

  Future<void> salvarRanking(RankingAdminModel ranking) {
    return _firestoreService.setDocument(
      collectionPath: AdminFirestoreCollections.ranking,
      documentId: ranking.id,
      data: {
        ...ranking.toMap(),
        'atualizadoEm': FieldValue.serverTimestamp(),
      },
    );
  }

  List<RankingAdminModel> _mapRanking(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs
        .map((doc) => RankingAdminModel.fromMap(doc.id, doc.data()))
        .toList();
  }
}
