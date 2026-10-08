import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
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
}
