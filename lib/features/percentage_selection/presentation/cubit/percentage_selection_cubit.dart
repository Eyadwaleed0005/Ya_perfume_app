import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ya_perfume/features/percentage_selection/domain/use_cases/get_closest_perfumes_use_case.dart';

import '../../domain/entities/fragrance_percentages.dart';
import 'percentage_selection_state.dart';

class PercentageSelectionCubit extends Cubit<PercentageSelectionState> {
  final GetClosestPerfumesUseCase getClosestPerfumesUseCase;

  PercentageSelectionCubit({
    required this.getClosestPerfumesUseCase,
  }) : super(const PercentageSelectionState());

  void updatePercentages({
    double? sweet,
    double? fresh,
    double? floral,
    double? woody,
  }) {
    if (state.status == PercentageSelectionStatus.loading) return;

    final percentages = FragrancePercentages(
      sweet: sweet ?? state.percentages.sweet,
      fresh: fresh ?? state.percentages.fresh,
      floral: floral ?? state.percentages.floral,
      woody: woody ?? state.percentages.woody,
    );

    final values = [
      percentages.sweet,
      percentages.fresh,
      percentages.floral,
      percentages.woody,
    ];

    final areValuesValid = values.every(
      (value) => value.isFinite && value >= 0 && value <= 100,
    );

    if (!areValuesValid) return;

    emit(
      state.copyWith(
        percentages: percentages,
        status: PercentageSelectionStatus.initial,
        perfumes: const [],
      ),
    );
  }

  Future<void> findClosestPerfumes() async {
    if (!state.canSubmit) return;

    final selection = state.percentages;

    emit(
      state.copyWith(
        status: PercentageSelectionStatus.loading,
        perfumes: const [],
      ),
    );

    final minimumLoadingTime = Future<void>.delayed(
      const Duration(seconds: 12),
    );

    final perfumes = await getClosestPerfumesUseCase(selection);

    await minimumLoadingTime;

    if (isClosed) return;

    emit(
      state.copyWith(
        status: PercentageSelectionStatus.success,
        perfumes: perfumes,
      ),
    );
  }
}