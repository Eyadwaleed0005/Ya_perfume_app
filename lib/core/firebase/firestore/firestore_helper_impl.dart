import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ya_perfume/core/firebase/firestore/firestore_helper.dart';

class FirestoreHelperImpl implements FirestoreHelper {
  final FirebaseFirestore firestore;

  FirestoreHelperImpl({required this.firestore});

  DocumentReference<Map<String, dynamic>> _document({
    required String collectionPath,
    required String documentId,
  }) {
    return firestore.collection(collectionPath).doc(documentId);
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> get({
    required String collectionPath,
    required String documentId,
    Source source = Source.server,
  }) {
    return _document(
      collectionPath: collectionPath,
      documentId: documentId,
    ).get(GetOptions(source: source));
  }

  @override
  Future<void> post({
    required String collectionPath,
    required String documentId,
    required Map<String, dynamic> data,
  }) {
    return _document(
      collectionPath: collectionPath,
      documentId: documentId,
    ).set(data);
  }

  @override
  Future<void> patch({
    required String collectionPath,
    required String documentId,
    required Map<String, dynamic> data,
  }) {
    return _document(
      collectionPath: collectionPath,
      documentId: documentId,
    ).update(data);
  }

  @override
  Future<void> delete({
    required String collectionPath,
    required String documentId,
  }) {
    return _document(
      collectionPath: collectionPath,
      documentId: documentId,
    ).delete();
  }
}
