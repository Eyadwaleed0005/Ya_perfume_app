import 'package:dartz/dartz.dart';
import 'package:ya_perfume/core/error/error_model.dart';
import 'package:ya_perfume/core/error/firebase_error_handler.dart';
import 'package:ya_perfume/features/app_activation/data/data_sources/app_activation_data_source.dart';
import 'package:ya_perfume/features/app_activation/domain/repositories/app_activation_repository.dart';

class AppActivationRepositoryImpl implements AppActivationRepository {
  final AppActivationDataSource dataSource;

  AppActivationRepositoryImpl({required this.dataSource});

  @override
  Future<Either<ErrorModel, bool>> getAppActivation() async {
    try {
      final result = await dataSource.getAppActivation();

      return Right(result?.isActive ?? true);
    } catch (exception) {
      final error = FirebaseErrorHandler.handle(exception);

      switch (error.code) {
        case 'unavailable':
        case 'deadline-exceeded':
        case 'network-request-failed':
          return const Right(true);

        default:
          return Left(error);
      }
    }
  }
}
