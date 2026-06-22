import '../../shared/models/frete_model.dart';
import '../services/fretes_service.dart';

class FretesRepository {
  FretesRepository({FretesService? fretesService})
      : _fretesService = fretesService ?? FretesService();

  final FretesService _fretesService;

  Stream<List<FreteModel>> listarDisponiveis() {
    return _fretesService.listarFretesDisponiveis();
  }
}
