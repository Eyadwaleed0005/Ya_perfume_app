import 'package:ya_perfume/features/questions/data/models/perfume_questions_model.dart';

abstract class QuestionsDataSource {
  Future<List<PerfumeQuestionsModel>> fetchPerfumes();
}
