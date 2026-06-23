import 'package:cloud_firestore/cloud_firestore.dart';

class AdminFirestoreService {
  AdminFirestoreService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> collection(String path) {
    return _firestore.collection(path);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDocument({
    required String collectionPath,
    required String documentId,
  }) {
    return collection(collectionPath).doc(documentId).get();
  }

  Future<void> setDocument({
    required String collectionPath,
    required String documentId,
    required Map<String, dynamic> data,
  }) {
    return collection(collectionPath).doc(documentId).set(data);
  }

  Future<void> updateDocument({
    required String collectionPath,
    required String documentId,
    required Map<String, dynamic> data,
  }) {
    return collection(collectionPath).doc(documentId).update(data);
  }

  Future<void> addDocument({
    required String collectionPath,
    required Map<String, dynamic> data,
  }) {
    return collection(collectionPath).add(data);
  }
}
