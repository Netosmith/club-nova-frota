import 'package:cloud_firestore/cloud_firestore.dart';

import '../../shared/models/beneficio_admin_model.dart';
import '../constants/admin_firestore_collections.dart';
import 'admin_firestore_service.dart';

class AdminBeneficiosService {
  AdminBeneficiosService({AdminFirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? AdminFirestoreService();

  final AdminFirestoreService _firestoreService;

  Stream<List<BeneficioAdminModel>> listarBeneficios() {
    return _firestoreService
        .collection(AdminFirestoreCollections.beneficios)
        .orderBy('titulo')
        .snapshots()
        .map(_mapBeneficios);
  }

  Future<void> salvarBeneficio(BeneficioAdminModel beneficio) {
    return _firestoreService.setDocument(
      collectionPath: AdminFirestoreCollections.beneficios,
      documentId: beneficio.id,
      data: {
        ...beneficio.toMap(),
        'atualizadoEm': FieldValue.serverTimestamp(),
      },
    );
  }

  Future<void> atualizarStatus({
    required String beneficioId,
    required bool ativo,
  }) {
    return _firestoreService.updateDocument(
      collectionPath: AdminFirestoreCollections.beneficios,
      documentId: beneficioId,
      data: {
        'ativo': ativo,
        'atualizadoEm': FieldValue.serverTimestamp(),
      },
    );
  }

  List<BeneficioAdminModel> _mapBeneficios(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    return snapshot.docs
        .map((doc) => BeneficioAdminModel.fromMap(doc.id, doc.data()))
        .toList();
  }
}
