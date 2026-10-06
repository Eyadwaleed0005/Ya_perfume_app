import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/core/animation/app_animation.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/features/percentage_selection/presentation/widgets/percentage_selection_background.dart';

import 'percentage_selection_actions.dart';
import 'percentage_selection_cards.dart';
import 'percentage_selection_header.dart';
import 'percentage_selection_total.dart';

class PercentageSelectionContent extends StatelessWidget {
  const PercentageSelectionContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const PercentageSelectionBackground(),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 64.w, vertical: 16.h),
            child: Column(
              children: [
                AppAnimation.percentageSelectionEntrance(
                  child: const PercentageSelectionHeader(),
                ),
                verticalSpace(16),
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 0.72,
                    heightFactor: 1,
                    alignment: Alignment.center,
                    child: AppAnimation.percentageSelectionEntrance(
                      delay: const Duration(milliseconds: 180),
                      child: const PercentageSelectionCards(),
                    ),
                  ),
                ),
                verticalSpace(12),
                AppAnimation.percentageSelectionEntrance(
                  delay: const Duration(milliseconds: 360),
                  child: const PercentageSelectionTotal(),
                ),
                verticalSpace(12),
                AppAnimation.percentageSelectionEntrance(
                  delay: const Duration(milliseconds: 540),
                  child: const PercentageSelectionActions(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
