import 'dart:io';

import 'package:flutter/material.dart';

import '../repositories/comprovantes_repository.dart';

class ComprovantesProvider extends ChangeNotifier {
  ComprovantesProvider({ComprovantesRepository? comprovantesRepository})
      : _comprovantesRepository = comprovantesRepository ?? ComprovantesRepository();

  final ComprovantesRepository _comprovantesRepository;

  bool _carregando = false;
  String? _erro;
  String? _ultimoArquivoUrl;

  bool get carregando => _carregando;
  String? get erro => _erro;
  String? get ultimoArquivoUrl => _ultimoArquivoUrl;

  Future<bool> enviarComprovante({
    required File arquivo,
    required String motoristaId,
    required String ordemId,
    required String nomeArquivo,
  }) async {
    _carregando = true;
    _erro = null;
    notifyListeners();

    try {
      _ultimoArquivoUrl = await _comprovantesRepository.enviarComprovante(
        arquivo: arquivo,
        motoristaId: motoristaId,
        ordemId: ordemId,
        nomeArquivo: nomeArquivo,
      );
      return true;
    } catch (_) {
      _erro = 'Não foi possível enviar o comprovante.';
      return false;
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }
}
