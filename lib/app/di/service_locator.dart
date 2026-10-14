import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:ya_perfume/core/firebase/firebase_helper.dart';
import 'package:ya_perfume/core/firebase/firebase_helper_impl.dart';
import 'package:ya_perfume/core/firebase/firestore/firestore_helper.dart';
import 'package:ya_perfume/core/firebase/firestore/firestore_helper_impl.dart';
import 'package:ya_perfume/features/app_activation/data/data_sources/app_activation_data_source.dart';
import 'package:ya_perfume/features/app_activation/data/data_sources/firebase_app_activation_data_source.dart';
import 'package:ya_perfume/features/app_activation/data/repositories/app_activation_repository_impl.dart';
import 'package:ya_perfume/features/app_activation/domain/repositories/app_activation_repository.dart';
import 'package:ya_perfume/features/app_activation/domain/use_cases/get_app_activation_use_case.dart';
import 'package:ya_perfume/features/app_activation/presentation/cubit/app_activation_cubit.dart';
import 'package:ya_perfume/features/percentage_selection/data/data_sources/local_percentage_selection_data_source.dart';
import 'package:ya_perfume/features/percentage_selection/data/data_sources/percentage_selection_data_source.dart';
import 'package:ya_perfume/features/percentage_selection/data/repositories/percentage_selection_repository_impl.dart';
import 'package:ya_perfume/features/percentage_selection/domain/repositories/percentage_selection_repository.dart';
import 'package:ya_perfume/features/percentage_selection/domain/use_cases/get_closest_perfumes_use_case.dart';
import 'package:ya_perfume/features/percentage_selection/presentation/cubit/percentage_selection_cubit.dart';
import 'package:ya_perfume/features/questions/data/adapters/perfume_questions_adapter.dart';
import 'package:ya_perfume/features/questions/data/data_sources/local_questions_data_source.dart';
import 'package:ya_perfume/features/questions/data/data_sources/questions_data_source.dart';
import 'package:ya_perfume/features/questions/data/repositories/questions_repository_impl.dart';
import 'package:ya_perfume/features/questions/domain/repositories/questions_repository.dart';
import 'package:ya_perfume/features/questions/domain/use_cases/get_perfumes_use_case.dart';
import 'package:ya_perfume/features/questions/presentation/cubit/questions_cubit.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Firebase
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  getIt.registerLazySingleton<FirestoreHelper>(
    () => FirestoreHelperImpl(firestore: getIt<FirebaseFirestore>()),
  );

  getIt.registerLazySingleton<FirebaseHelper>(
    () => FirebaseHelperImpl(firestoreHelper: getIt<FirestoreHelper>()),
  );

  // Percentage Selection
  getIt.registerLazySingleton<PercentageSelectionDataSource>(
    () => LocalPercentageSelectionDataSource(assetBundle: rootBundle),
  );

  getIt.registerLazySingleton<PercentageSelectionRepository>(
    () => PercentageSelectionRepositoryImpl(
      dataSource: getIt<PercentageSelectionDataSource>(),
    ),
  );

  getIt.registerLazySingleton<GetClosestPerfumesUseCase>(
    () => GetClosestPerfumesUseCase(getIt<PercentageSelectionRepository>()),
  );

  getIt.registerFactory<PercentageSelectionCubit>(
    () => PercentageSelectionCubit(
      getClosestPerfumesUseCase: getIt<GetClosestPerfumesUseCase>(),
    ),
  );

  // Questions
  getIt.registerLazySingleton<QuestionsDataSource>(
    () => LocalQuestionsDataSource(assetBundle: rootBundle),
  );

  getIt.registerLazySingleton<QuestionsRepository>(
    () => QuestionsRepositoryImpl(dataSource: getIt<QuestionsDataSource>()),
  );

  getIt.registerLazySingleton<GetPerfumesUseCase>(
    () => GetPerfumesUseCase(getIt<QuestionsRepository>()),
  );

  getIt.registerLazySingleton<PerfumeQuestionsAdapter>(
    () => PerfumeQuestionsAdapter(),
  );

  getIt.registerFactory<QuestionsCubit>(
    () => QuestionsCubit(
      getPerfumesUseCase: getIt<GetPerfumesUseCase>(),
      perfumeQuestionsAdapter: getIt<PerfumeQuestionsAdapter>(),
    ),
  );

  // App Activation
  getIt.registerLazySingleton<AppActivationDataSource>(
    () => FirebaseAppActivationDataSource(
      firebaseHelper: getIt<FirebaseHelper>(),
    ),
  );

  getIt.registerLazySingleton<AppActivationRepository>(
    () => AppActivationRepositoryImpl(
      dataSource: getIt<AppActivationDataSource>(),
    ),
  );

  getIt.registerLazySingleton<GetAppActivationUseCase>(
    () => GetAppActivationUseCase(getIt<AppActivationRepository>()),
  );

  getIt.registerFactory<AppActivationCubit>(
    () => AppActivationCubit(
      getAppActivationUseCase: getIt<GetAppActivationUseCase>(),
    ),
  );
}
