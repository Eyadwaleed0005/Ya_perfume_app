import '../entities/perfume_entity.dart';

abstract class PercentageSelectionRepository {
  Future<List<PerfumeEntity>> getPerfumes();
}