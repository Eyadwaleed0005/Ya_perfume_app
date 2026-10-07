import 'package:ya_perfume/features/questions/domain/entities/perfume_questions_entity.dart';
import 'package:ya_perfume/features/questions/domain/repositories/questions_repository.dart';

import '../data_sources/questions_data_source.dart';

class QuestionsRepositoryImpl implements QuestionsRepository {
  final QuestionsDataSource dataSource;

  const QuestionsRepositoryImpl({required this.dataSource});

  @override
  Future<List<PerfumeQuestionsEntity>> fetchPerfumes() {
    return dataSource.fetchPerfumes();
  }
}
