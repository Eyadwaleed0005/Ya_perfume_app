import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/features/percentage_selection/presentation/widgets/percentage_selection_screen_widgets/percentage_selection_card.dart';

import '../../cubit/percentage_selection_cubit.dart';
import '../../cubit/percentage_selection_state.dart';

class PercentageSelectionCards extends StatelessWidget {
  const PercentageSelectionCards({super.key});

  static const double step = 5;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PercentageSelectionCubit, PercentageSelectionState>(
      builder: (context, state) {
        final cubit = context.read<PercentageSelectionCubit>();
        final percentages = state.percentages;
        final isLoading =
            state.status == PercentageSelectionStatus.loading;

        Widget buildCard({
          required String titleKey,
          required double percentage,
          required Color liquidColor,
          required ValueChanged<double> onChanged,
        }) {
          return PercentageSelectionCard(
            title: titleKey.tr(),
            percentage: percentage,
            liquidColor: liquidColor,
            onIncrease: isLoading || percentage >= 100
                ? null
                : () => onChanged(
                      (percentage + step).clamp(0.0, 100.0).toDouble(),
                    ),
            onDecrease: isLoading || percentage <= 0
                ? null
                : () => onChanged(
                      (percentage - step).clamp(0.0, 100.0).toDouble(),
                    ),
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildCard(
              titleKey: 'percentage_family_warm',
              percentage: percentages.sweet,
              liquidColor: AppColors.goldAccent.withValues(alpha: 0.35),
              onChanged: (value) => cubit.updatePercentages(sweet: value),
            ),
            buildCard(
              titleKey: 'percentage_family_fresh',
              percentage: percentages.fresh,
              liquidColor: AppColors.borderSnow.withValues(alpha: 0.35),
              onChanged: (value) => cubit.updatePercentages(fresh: value),
            ),
            buildCard(
              titleKey: 'percentage_family_woody',
              percentage: percentages.woody,
              liquidColor: AppColors.darkAutumnBrown.withValues(alpha: 0.5),
              onChanged: (value) => cubit.updatePercentages(woody: value),
            ),
            buildCard(
              titleKey: 'percentage_family_floral',
              percentage: percentages.floral,
              liquidColor: const Color(0xFF51424C),
              onChanged: (value) => cubit.updatePercentages(floral: value),
            ),
          ],
        );
      },
    );
  }
}