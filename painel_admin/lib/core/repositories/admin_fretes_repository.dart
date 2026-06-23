import '../../shared/models/frete_admin_model.dart';
import '../services/admin_fretes_service.dart';

class AdminFretesRepository {
  AdminFretesRepository({AdminFretesService? fretesService})
      : _fretesService = fretesService ?? AdminFretesService();

  final AdminFretesService _fretesService;

  Stream<List<FreteAdminModel>> listarFretes() {
    return _fretesService.listarFretes();
  }

  Future<void> salvarFrete(FreteAdminModel frete) {
    return _fretesService.salvarFrete(frete);
  }

  Future<void> liberarFrete(String freteId) {
    return _fretesService.atualizarStatus(
      freteId: freteId,
      status: 'disponivel',
    );
  }

  Future<void> encerrarFrete(String freteId) {
    return _fretesService.atualizarStatus(
      freteId: freteId,
      status: 'encerrado',
    );
  }

  Future<void> cancelarFrete(String freteId) {
    return _fretesService.atualizarStatus(
      freteId: freteId,
      status: 'cancelado',
    );
  }
}
