import '../entities/fragrance_percentages.dart';
import '../entities/perfume_entity.dart';
import '../repositories/percentage_selection_repository.dart';

class GetClosestPerfumesUseCase {
  final PercentageSelectionRepository repository;

  const GetClosestPerfumesUseCase(this.repository);

  Future<List<PerfumeEntity>> call(FragrancePercentages selection) async {
    final perfumes = await repository.getPerfumes();

    final rankedPerfumes = perfumes.map((perfume) {
      return (
        perfume: perfume,
        difference: selection.differenceFrom(perfume.percentages),
      );
    }).toList();

    rankedPerfumes.sort((first, second) {
      final comparison = first.difference.compareTo(second.difference);

      if (comparison != 0) return comparison;

      return first.perfume.name.compareTo(second.perfume.name);
    });

    return rankedPerfumes
        .take(4)
        .map((match) => match.perfume)
        .toList(growable: false);
  }
}
