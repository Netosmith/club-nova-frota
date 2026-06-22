import '../../shared/models/ordem_model.dart';
import '../services/ordens_service.dart';

class OrdensRepository {
  OrdensRepository({OrdensService? ordensService})
      : _ordensService = ordensService ?? OrdensService();

  final OrdensService _ordensService;

  Stream<List<OrdemModel>> listarDoMotorista(String motoristaId) {
    return _ordensService.listarOrdensDoMotorista(motoristaId);
  }

  Future<void> solicitarOrdem({
    required String motoristaId,
    required String freteId,
  }) {
    return _ordensService.solicitarOrdem(
      motoristaId: motoristaId,
      freteId: freteId,
    );
  }
}
