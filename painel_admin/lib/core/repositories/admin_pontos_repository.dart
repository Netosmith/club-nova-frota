import '../../shared/models/pontos_admin_model.dart';
import '../services/admin_pontos_service.dart';

class AdminPontosRepository {
  AdminPontosRepository({AdminPontosService? pontosService})
      : _pontosService = pontosService ?? AdminPontosService();

  final AdminPontosService _pontosService;

  Stream<List<PontosAdminModel>> listarPontos() {
    return _pontosService.listarPontos();
  }

  Future<void> salvarMovimentacao(PontosAdminModel pontos) {
    return _pontosService.salvarMovimentacao(pontos);
  }
}
