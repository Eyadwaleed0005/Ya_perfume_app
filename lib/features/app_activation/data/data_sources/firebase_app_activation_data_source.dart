import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ya_perfume/core/firebase/firebase_helper.dart';
import 'package:ya_perfume/core/firebase/firestore/firestore_keys.dart';
import 'package:ya_perfume/features/app_activation/data/data_sources/app_activation_data_source.dart';
import 'package:ya_perfume/features/app_activation/data/models/app_activation_model.dart';

class FirebaseAppActivationDataSource implements AppActivationDataSource {
  final FirebaseHelper firebaseHelper;

  FirebaseAppActivationDataSource({
    required this.firebaseHelper,
  });

  @override
  Future<AppActivationModel?> getAppActivation() async {
    final snapshot = await firebaseHelper.get(
      collectionPath: FirestoreKeys.appConfig,
      documentId: FirestoreKeys.activation,
      source: Source.serverAndCache,
    );

    final data = snapshot.data();

    return data == null ? null : AppActivationModel.fromJson(data);
  }
}