import 'package:flutter/material.dart';

import '../../shared/models/frete_model.dart';
import '../repositories/fretes_repository.dart';

class FretesProvider extends ChangeNotifier {
  FretesProvider({FretesRepository? fretesRepository})
      : _fretesRepository = fretesRepository ?? FretesRepository();

  final FretesRepository _fretesRepository;

  List<FreteModel> _fretes = [];
  bool _carregando = false;
  String? _erro;

  List<FreteModel> get fretes => _fretes;
  bool get carregando => _carregando;
  String? get erro => _erro;

  void acompanharFretesDisponiveis() {
    _carregando = true;
    notifyListeners();

    _fretesRepository.listarDisponiveis().listen(
      (lista) {
        _fretes = lista;
        _carregando = false;
        _erro = null;
        notifyListeners();
      },
      onError: (_) {
        _erro = 'Não foi possível carregar os fretes.';
        _carregando = false;
        notifyListeners();
      },
    );
  }
}
