import 'package:dartz/dartz.dart';
import 'package:ya_perfume/core/error/error_model.dart';

abstract interface class AppActivationRepository {
  Future<Either<ErrorModel, bool>> getAppActivation();
}