import 'package:ya_perfume/core/firebase/firestore/firestore_keys.dart';

class AppActivationModel {
  final bool isActive;

  const AppActivationModel({required this.isActive});

  factory AppActivationModel.fromJson(Map<String, dynamic> json) {
    return AppActivationModel(isActive: json[FirestoreKeys.isActive] as bool);
  }
}
