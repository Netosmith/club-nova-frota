import '../../shared/models/comprovante_admin_model.dart';
import '../services/admin_comprovantes_service.dart';

class AdminComprovantesRepository {
  AdminComprovantesRepository({AdminComprovantesService? comprovantesService})
      : _comprovantesService = comprovantesService ?? AdminComprovantesService();

  final AdminComprovantesService _comprovantesService;

  Stream<List<ComprovanteAdminModel>> listarComprovantes() {
    return _comprovantesService.listarComprovantes();
  }

  Future<void> aprovarComprovante({
    required String comprovanteId,
    required String analisadoPor,
  }) {
    return _comprovantesService.aprovarComprovante(
      comprovanteId: comprovanteId,
      analisadoPor: analisadoPor,
    );
  }

  Future<void> rejeitarComprovante({
    required String comprovanteId,
    required String analisadoPor,
  }) {
    return _comprovantesService.rejeitarComprovante(
      comprovanteId: comprovanteId,
      analisadoPor: analisadoPor,
    );
  }
}
