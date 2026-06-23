import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/firestore_collections.dart';
import 'firestore_service.dart';
import 'storage_service.dart';

class ComprovantesService {
  ComprovantesService({
    StorageService? storageService,
    FirestoreService? firestoreService,
  })  : _storageService = storageService ?? StorageService(),
        _firestoreService = firestoreService ?? FirestoreService();

  final StorageService _storageService;
  final FirestoreService _firestoreService;

  Future<String> enviarComprovante({
    required File arquivo,
    required String motoristaId,
    required String ordemId,
    required String nomeArquivo,
  }) async {
    final caminho = 'comprovantes/$motoristaId/$ordemId/$nomeArquivo';

    final url = await _storageService.uploadArquivo(
      arquivo: arquivo,
      caminho: caminho,
    );

    await _firestoreService.updateDocument(
      collectionPath: FirestoreCollections.ordens,
      documentId: ordemId,
      data: {
        'comprovanteUrl': url,
        'status': 'comprovante_enviado',
        'comprovanteEnviadoEm': FieldValue.serverTimestamp(),
        'atualizadoEm': FieldValue.serverTimestamp(),
      },
    );

    return url;
  }
}
