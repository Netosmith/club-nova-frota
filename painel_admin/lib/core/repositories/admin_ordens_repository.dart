import '../../shared/models/ordem_admin_model.dart';
import '../services/admin_ordens_service.dart';

class AdminOrdensRepository {
  AdminOrdensRepository({AdminOrdensService? ordensService})
      : _ordensService = ordensService ?? AdminOrdensService();

  final AdminOrdensService _ordensService;

  Stream<List<OrdemAdminModel>> listarOrdens() {
    return _ordensService.listarOrdens();
  }

  Future<void> aprovarOrdem(String ordemId) {
    return _ordensService.aprovarOrdem(ordemId);
  }

  Future<void> rejeitarOrdem(String ordemId) {
    return _ordensService.rejeitarOrdem(ordemId);
  }

  Future<void> atualizarStatus({
    required String ordemId,
    required String status,
  }) {
    return _ordensService.atualizarStatus(
      ordemId: ordemId,
      status: status,
    );
  }
}
