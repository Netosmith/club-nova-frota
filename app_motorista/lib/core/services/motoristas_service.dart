import '../../shared/models/motorista_model.dart';
import 'firestore_service.dart';

class MotoristasService {
  MotoristasService({FirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? FirestoreService();

  final FirestoreService _firestoreService;

  Future<MotoristaModel?> buscarMotorista(String motoristaId) async {
    final doc = await _firestoreService.getDocument(
      collectionPath: 'motoristas',
      documentId: motoristaId,
    );

    final data = doc.data();
    if (data == null) return null;

    return MotoristaModel.fromMap(doc.id, data);
  }
}
