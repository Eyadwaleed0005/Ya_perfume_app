import 'package:ya_perfume/features/app_activation/data/models/app_activation_model.dart';

abstract interface class AppActivationDataSource {
  Future<AppActivationModel?> getAppActivation();
}