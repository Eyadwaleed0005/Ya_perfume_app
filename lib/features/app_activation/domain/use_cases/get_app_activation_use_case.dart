import 'package:dartz/dartz.dart';
import 'package:ya_perfume/core/error/error_model.dart';
import 'package:ya_perfume/features/app_activation/domain/repositories/app_activation_repository.dart';

class GetAppActivationUseCase {
  final AppActivationRepository repository;

  GetAppActivationUseCase(this.repository);

  Future<Either<ErrorModel, bool>> call() {
    return repository.getAppActivation();
  }
}