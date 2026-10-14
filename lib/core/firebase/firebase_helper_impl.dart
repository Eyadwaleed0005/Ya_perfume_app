import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ya_perfume/core/firebase/firebase_helper.dart';
import 'package:ya_perfume/core/firebase/firestore/firestore_helper.dart';

class FirebaseHelperImpl implements FirebaseHelper {
  final FirestoreHelper firestoreHelper;

  FirebaseHelperImpl({required this.firestoreHelper});

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> get({
    required String collectionPath,
    required String documentId,
    Source source = Source.server,
  }) {
    return firestoreHelper.get(
      collectionPath: collectionPath,
      documentId: documentId,
      source: source,
    );
  }

  @override
  Future<void> post({
    required String collectionPath,
    required String documentId,
    required Map<String, dynamic> data,
  }) {
    return firestoreHelper.post(
      collectionPath: collectionPath,
      documentId: documentId,
      data: data,
    );
  }

  @override
  Future<void> patch({
    required String collectionPath,
    required String documentId,
    required Map<String, dynamic> data,
  }) {
    return firestoreHelper.patch(
      collectionPath: collectionPath,
      documentId: documentId,
      data: data,
    );
  }

  @override
  Future<void> delete({
    required String collectionPath,
    required String documentId,
  }) {
    return firestoreHelper.delete(
      collectionPath: collectionPath,
      documentId: documentId,
    );
  }
}
