import '../../domain/entities/fragrance_percentages.dart';
import '../../domain/entities/perfume_entity.dart';

enum PercentageSelectionStatus { initial, loading, success }

class PercentageSelectionState {
  final FragrancePercentages percentages;
  final PercentageSelectionStatus status;
  final List<PerfumeEntity> perfumes;

  const PercentageSelectionState({
    this.percentages = const FragrancePercentages(
      sweet: 0,
      fresh: 0,
      floral: 0,
      woody: 0,
    ),
    this.status = PercentageSelectionStatus.initial,
    this.perfumes = const [],
  });

  double get total => percentages.total;

  bool get canSubmit =>
      percentages.isValidSelection &&
      status != PercentageSelectionStatus.loading;

  PercentageSelectionState copyWith({
    FragrancePercentages? percentages,
    PercentageSelectionStatus? status,
    List<PerfumeEntity>? perfumes,
  }) {
    return PercentageSelectionState(
      percentages: percentages ?? this.percentages,
      status: status ?? this.status,
      perfumes: perfumes ?? this.perfumes,
    );
  }
}
