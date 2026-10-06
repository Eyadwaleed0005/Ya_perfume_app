import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/textstyles.dart';
import 'package:ya_perfume/features/percentage_selection/presentation/cubit/percentage_selection_cubit.dart';
import 'package:ya_perfume/features/percentage_selection/presentation/cubit/percentage_selection_state.dart';

class PercentageSelectionTotal extends StatelessWidget {
  const PercentageSelectionTotal({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      PercentageSelectionCubit,
      PercentageSelectionState,
      double
    >(
      selector: (state) => state.total,
      builder: (context, total) {
        final isTotalValid = (total - 100).abs() < 0.001;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              textDirection: ui.TextDirection.ltr,
              children: [
                Text(
                  '${total.toStringAsFixed(0)}%',
                  textDirection: ui.TextDirection.ltr,
                  style: AppTextStyle.font18TextAccentMediumNoto(),
                ),
                horizontalSpace(8),
                Text(
                  'percentage_selection_total'.tr(),
                  style: AppTextStyle.font18TextAccentMediumNoto(),
                ),
              ],
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.15),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: isTotalValid
                    ? const SizedBox.shrink()
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          verticalSpace(8),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            textDirection: ui.TextDirection.ltr,
                            children: [
                              Text(
                                '100%',
                                textDirection: ui.TextDirection.ltr,
                                style:
                                    AppTextStyle.font16textMutedRegularNoto(),
                              ),
                              horizontalSpace(4),
                              Text(
                                'percentage_selection_adjust_total'.tr(),
                                style:
                                    AppTextStyle.font16textMutedRegularNoto(),
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
