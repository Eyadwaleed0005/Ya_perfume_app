import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/app_color.dart';

import '../../cubit/percentage_selection_cubit.dart';
import '../../cubit/percentage_selection_state.dart';
import 'percentage_selection_card.dart';

class PercentageSelectionCards extends StatelessWidget {
  const PercentageSelectionCards({super.key});

  static const double step = 5;
  static const double minimumRowWidth = 1100;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PercentageSelectionCubit, PercentageSelectionState>(
      builder: (context, state) {
        final cubit = context.read<PercentageSelectionCubit>();
        final percentages = state.percentages;
        final isLoading = state.status == PercentageSelectionStatus.loading;

        Widget buildCard({
          required String titleKey,
          required double percentage,
          required Color liquidColor,
          required ValueChanged<double> onChanged,
        }) {
          return Expanded(
            child: PercentageSelectionCard(
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
            ),
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth <= 0) {
              return const SizedBox.shrink();
            }

            final rowWidth = math.max(minimumRowWidth, constraints.maxWidth);

            return FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: rowWidth,
                child: Row(
                  textDirection: ui.TextDirection.ltr,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildCard(
                      titleKey: 'percentage_family_sweet',
                      percentage: percentages.sweet,
                      liquidColor: AppColors.sweetLiquid,
                      onChanged: (value) =>
                          cubit.updatePercentages(sweet: value),
                    ),
                    horizontalSpace(16),
                    buildCard(
                      titleKey: 'percentage_family_fresh',
                      percentage: percentages.fresh,
                      liquidColor: AppColors.freshLiquid,
                      onChanged: (value) =>
                          cubit.updatePercentages(fresh: value),
                    ),
                    horizontalSpace(16),
                    buildCard(
                      titleKey: 'percentage_family_woody',
                      percentage: percentages.woody,
                      liquidColor: AppColors.woodyLiquid,
                      onChanged: (value) =>
                          cubit.updatePercentages(woody: value),
                    ),
                    horizontalSpace(16),
                    buildCard(
                      titleKey: 'percentage_family_floral',
                      percentage: percentages.floral,
                      liquidColor: AppColors.floralLiquid,
                      onChanged: (value) =>
                          cubit.updatePercentages(floral: value),
                    ),
                    horizontalSpace(16),
                    buildCard(
                      titleKey: 'percentage_family_fruity',
                      percentage: percentages.fruity,
                      liquidColor: AppColors.fruityLiquid,
                      onChanged: (value) =>
                          cubit.updatePercentages(fruity: value),
                    ),
                    horizontalSpace(16),
                    buildCard(
                      titleKey: 'percentage_family_white_floral_jasmin',
                      percentage: percentages.whiteFloralJasmin,
                      liquidColor: AppColors.whiteFloralJasminLiquid,
                      onChanged: (value) =>
                          cubit.updatePercentages(whiteFloralJasmin: value),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
