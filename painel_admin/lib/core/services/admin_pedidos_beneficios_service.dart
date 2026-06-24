import 'package:cloud_firestore/cloud_firestore.dart';

import '../../shared/models/pedido_beneficio_admin_model.dart';
import 'admin_firestore_service.dart';

class AdminPedidosBeneficiosService {
  AdminPedidosBeneficiosService({AdminFirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? AdminFirestoreService();

  final AdminFirestoreService _firestoreService;

  Stream<List<PedidoBeneficioAdminModel>> listarPedidos() {
    return _firestoreService
        .collection('pedidos_beneficios')
        .snapshots()
        .map(_mapPedidos);
  }

  Future<void> atualizarSituacao({
    required String pedidoId,
    required String situacao,
  }) {
    return _firestoreService.updateDocument(
      collectionPath: 'pedidos_beneficios',
      documentId: pedidoId,
      data: {
        'situacao': situacao,
        'atualizadoEm': FieldValue.serverTimestamp(),
      },
    );
  }

  List<PedidoBeneficioAdminModel> _mapPedidos(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    return snapshot.docs
        .map((doc) => PedidoBeneficioAdminModel.fromMap(doc.id, doc.data()))
        .toList();
  }
}
