import '../../shared/models/motorista_admin_model.dart';
import '../services/admin_motoristas_service.dart';

class AdminMotoristasRepository {
  AdminMotoristasRepository({AdminMotoristasService? motoristasService})
      : _motoristasService = motoristasService ?? AdminMotoristasService();

  final AdminMotoristasService _motoristasService;

  Stream<List<MotoristaAdminModel>> listarMotoristas() {
    return _motoristasService.listarMotoristas();
  }

  Future<void> salvarMotorista(MotoristaAdminModel motorista) {
    return _motoristasService.salvarMotorista(motorista);
  }

  Future<void> ativarMotorista(String motoristaId) {
    return _motoristasService.atualizarStatus(
      motoristaId: motoristaId,
      ativo: true,
    );
  }

  Future<void> bloquearMotorista(String motoristaId) {
    return _motoristasService.atualizarStatus(
      motoristaId: motoristaId,
      ativo: false,
    );
  }
}
