import 'package:cloud_firestore/cloud_firestore.dart';

abstract interface class FirebaseHelper {
  Future<DocumentSnapshot<Map<String, dynamic>>> get({
    required String collectionPath,
    required String documentId,
    Source source = Source.server,
  });

  Future<void> post({
    required String collectionPath,
    required String documentId,
    required Map<String, dynamic> data,
  });

  Future<void> patch({
    required String collectionPath,
    required String documentId,
    required Map<String, dynamic> data,
  });

  Future<void> delete({
    required String collectionPath,
    required String documentId,
  });
}
