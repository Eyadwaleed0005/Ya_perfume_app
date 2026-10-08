import 'package:ya_perfume/features/questions/domain/entities/perfume_questions_entity.dart';

import '../repositories/questions_repository.dart';

class GetPerfumesUseCase {
  final QuestionsRepository repository;

  const GetPerfumesUseCase(this.repository);

  Future<List<PerfumeQuestionsEntity>> call(
    PerfumeQuestionsEntity questionsEntity,
  ) async {
    final perfumes = await repository.fetchPerfumes();

    final filteredPerfumes = perfumes.map((perfume) {
      int numOfAcceptance = 0;

      if (perfume.gender == questionsEntity.gender) {
        numOfAcceptance++;
      }
      if (perfume.ageGroups.any(questionsEntity.ageGroups.contains)) {
        numOfAcceptance++;
      }
      if (perfume.usageTime == questionsEntity.usageTime) {
        numOfAcceptance++;
      }
      if (perfume.season == questionsEntity.season) {
        numOfAcceptance++;
      }
      numOfAcceptance += perfume.preferredScents
          .where((e) => questionsEntity.preferredScents.contains(e))
          .length;

      if (questionsEntity.avoidedScents.isNotEmpty) {
        numOfAcceptance += perfume.avoidedScents
            .where((e) => questionsEntity.avoidedScents.contains(e))
            .length;
      }

      if (perfume.occasions.any(questionsEntity.occasions.contains)) {
        numOfAcceptance++;
      }
      if (perfume.styles.any(questionsEntity.styles.contains)) {
        numOfAcceptance++;
      }
      if (perfume.projection == questionsEntity.projection) {
        numOfAcceptance++;
      }

      return perfume.copyWith(
        //code: perfume.code,
        name: perfume.name,
        numOfAcceptance: numOfAcceptance,
      );
    }).toList();

    filteredPerfumes.sort(
      (a, b) => b.numOfAcceptance.compareTo(a.numOfAcceptance),
    );

    return filteredPerfumes.take(4).toList();
  }
}
