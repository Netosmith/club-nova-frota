import 'package:cloud_firestore/cloud_firestore.dart';

import '../../shared/models/ordem_model.dart';
import '../constants/firestore_collections.dart';
import 'firestore_service.dart';

class OrdensService {
  OrdensService({FirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? FirestoreService();

  final FirestoreService _firestoreService;

  Stream<List<OrdemModel>> listarOrdensDoMotorista(String motoristaId) {
    return _firestoreService
        .collection(FirestoreCollections.ordens)
        .where('motoristaId', isEqualTo: motoristaId)
        .snapshots()
        .map(_mapOrdens);
  }

  Future<void> solicitarOrdem({
    required String motoristaId,
    required String freteId,
  }) {
    return _firestoreService.addDocument(
      collectionPath: FirestoreCollections.ordens,
      data: {
        'motoristaId': motoristaId,
        'freteId': freteId,
        'status': 'solicitada',
        'comprovanteUrl': '',
        'observacoes': '',
        'solicitadaEm': FieldValue.serverTimestamp(),
        'criadoEm': FieldValue.serverTimestamp(),
        'atualizadoEm': FieldValue.serverTimestamp(),
      },
    );
  }

  List<OrdemModel> _mapOrdens(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs
        .map((doc) => OrdemModel.fromMap(doc.id, doc.data()))
        .toList();
  }
}
