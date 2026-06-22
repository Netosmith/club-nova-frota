import 'package:cloud_firestore/cloud_firestore.dart';

import '../../shared/models/frete_model.dart';
import '../constants/firestore_collections.dart';
import 'firestore_service.dart';

class FretesService {
  FretesService({FirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? FirestoreService();

  final FirestoreService _firestoreService;

  Stream<List<FreteModel>> listarFretesDisponiveis() {
    return _firestoreService
        .collection(FirestoreCollections.fretes)
        .where('status', isEqualTo: 'disponivel')
        .snapshots()
        .map(_mapFretes);
  }

  List<FreteModel> _mapFretes(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs
        .map((doc) => FreteModel.fromMap(doc.id, doc.data()))
        .toList();
  }
}
