import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/widgets/custom_button.dart';

import '../../cubit/percentage_selection_cubit.dart';
import '../../cubit/percentage_selection_state.dart';

class PercentageSelectionActions extends StatelessWidget {
  const PercentageSelectionActions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PercentageSelectionCubit, PercentageSelectionState>(
      builder: (context, state) {
        final isLoading = state.status == PercentageSelectionStatus.loading;

        return Row(
          textDirection: ui.TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton(
              text: 'percentage_selection_choose_method'.tr(),
              onPressed: isLoading ? null : () => Navigator.of(context).pop(),
              width: 230.w,
              height: 52.h,
              background: AppColors.bgCanvas,
              foreground: AppColors.textPrimary,
              borderColor: AppColors.borderSubtle,
              borderWidth: 0.5.w,
            ),
            CustomButton(
              text: 'percentage_selection_show_suggestions'.tr(),
              onPressed: state.canSubmit
                  ? () {
                      context
                          .read<PercentageSelectionCubit>()
                          .findClosestPerfumes();
                    }
                  : null,
              width: 280.w,
              height: 52.h,
              background: state.canSubmit
                  ? AppColors.bgAccent
                  : AppColors.bgAccent.withValues(alpha: 0.5),
              foreground: AppColors.textUltraBlack,
            ),
          ],
        );
      },
    );
  }
}
