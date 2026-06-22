import '../../shared/models/motorista_model.dart';
import '../services/motoristas_service.dart';

class MotoristasRepository {
  MotoristasRepository({MotoristasService? motoristasService})
      : _motoristasService = motoristasService ?? MotoristasService();

  final MotoristasService _motoristasService;

  Future<MotoristaModel?> buscarMotorista(String motoristaId) {
    return _motoristasService.buscarMotorista(motoristaId);
  }
}
