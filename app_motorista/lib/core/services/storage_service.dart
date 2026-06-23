import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  StorageService({FirebaseStorage? storage})
      : _storage = storage ?? FirebaseStorage.instance;

  final FirebaseStorage _storage;

  Future<String> uploadArquivo({
    required File arquivo,
    required String caminho,
  }) async {
    final ref = _storage.ref(caminho);
    final uploadTask = await ref.putFile(arquivo);
    return uploadTask.ref.getDownloadURL();
  }
}
