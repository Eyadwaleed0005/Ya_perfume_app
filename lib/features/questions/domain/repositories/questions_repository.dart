import 'package:ya_perfume/features/questions/domain/entities/perfume_questions_entity.dart';

abstract class QuestionsRepository {
  Future<List<PerfumeQuestionsEntity>> fetchPerfumes();
}
