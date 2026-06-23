import 'dart:io';

import '../services/comprovantes_service.dart';

class ComprovantesRepository {
  ComprovantesRepository({ComprovantesService? comprovantesService})
      : _comprovantesService = comprovantesService ?? ComprovantesService();

  final ComprovantesService _comprovantesService;

  Future<String> enviarComprovante({
    required File arquivo,
    required String motoristaId,
    required String ordemId,
    required String nomeArquivo,
  }) {
    return _comprovantesService.enviarComprovante(
      arquivo: arquivo,
      motoristaId: motoristaId,
      ordemId: ordemId,
      nomeArquivo: nomeArquivo,
    );
  }
}
