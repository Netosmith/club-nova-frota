import '../../shared/models/beneficio_admin_model.dart';
import '../services/admin_beneficios_service.dart';

class AdminBeneficiosRepository {
  AdminBeneficiosRepository({AdminBeneficiosService? beneficiosService})
      : _beneficiosService = beneficiosService ?? AdminBeneficiosService();

  final AdminBeneficiosService _beneficiosService;

  Stream<List<BeneficioAdminModel>> listarBeneficios() {
    return _beneficiosService.listarBeneficios();
  }

  Future<void> salvarBeneficio(BeneficioAdminModel beneficio) {
    return _beneficiosService.salvarBeneficio(beneficio);
  }

  Future<void> ativarBeneficio(String beneficioId) {
    return _beneficiosService.atualizarStatus(
      beneficioId: beneficioId,
      ativo: true,
    );
  }

  Future<void> inativarBeneficio(String beneficioId) {
    return _beneficiosService.atualizarStatus(
      beneficioId: beneficioId,
      ativo: false,
    );
  }
}
