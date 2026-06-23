import 'package:cloud_firestore/cloud_firestore.dart';

import '../../shared/models/motorista_admin_model.dart';
import '../constants/admin_firestore_collections.dart';
import 'admin_firestore_service.dart';

class AdminMotoristasService {
  AdminMotoristasService({AdminFirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? AdminFirestoreService();

  final AdminFirestoreService _firestoreService;

  Stream<List<MotoristaAdminModel>> listarMotoristas() {
    return _firestoreService
        .collection(AdminFirestoreCollections.motoristas)
        .orderBy('nome')
        .snapshots()
        .map(_mapMotoristas);
  }

  Future<void> salvarMotorista(MotoristaAdminModel motorista) {
    return _firestoreService.setDocument(
      collectionPath: AdminFirestoreCollections.motoristas,
      documentId: motorista.id,
      data: {
        ...motorista.toMap(),
        'atualizadoEm': FieldValue.serverTimestamp(),
      },
    );
  }

  Future<void> atualizarStatus({
    required String motoristaId,
    required bool ativo,
  }) {
    return _firestoreService.updateDocument(
      collectionPath: AdminFirestoreCollections.motoristas,
      documentId: motoristaId,
      data: {
        'ativo': ativo,
        'atualizadoEm': FieldValue.serverTimestamp(),
      },
    );
  }

  List<MotoristaAdminModel> _mapMotoristas(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs
        .map((doc) => MotoristaAdminModel.fromMap(doc.id, doc.data()))
        .toList();
  }
}
