import '../../domain/entities/perfume_entity.dart';
import '../../domain/repositories/percentage_selection_repository.dart';
import '../data_sources/percentage_selection_data_source.dart';

class PercentageSelectionRepositoryImpl
    implements PercentageSelectionRepository {
  final PercentageSelectionDataSource dataSource;

  const PercentageSelectionRepositoryImpl({required this.dataSource});

  @override
  Future<List<PerfumeEntity>> getPerfumes() {
    return dataSource.getPerfumes();
  }
}
