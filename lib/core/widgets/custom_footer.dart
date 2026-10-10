import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ya_perfume/app/routes/route_names.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/theme/app_theme.dart';
import 'package:ya_perfume/core/theme/app_theme_colors.dart';
import 'package:ya_perfume/core/widgets/custom_button.dart';
import 'package:ya_perfume/features/questions/presentation/cubit/questions_cubit.dart';

class CustomFooter extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final bool canGoNext;
  final int numberSelected;
  final String? questionId;
  final VoidCallback? onSkip;
  final QuestionsCubit cubit;
  final Widget? centerWidget;

  const CustomFooter({
    super.key,
    required this.onNext,
    required this.onPrevious,
    required this.canGoNext,
    required this.numberSelected,
    this.questionId,
    this.onSkip,
    required this.cubit,
    this.centerWidget,
  });

  void _handleNext(BuildContext context) {
    if (questionId == '4') {
      Navigator.of(context).pushNamed(
        RouteNames.beforeTheFamilies,
        arguments: cubit.state.selectedThemeType,
      );

      cubit.next();
      return;
    }

    if (questionId == '9') {
      cubit.getPerfumes();
      return;
    }

    onNext();
  }

  Widget _previousButton({
    required BuildContext context,
    required AppThemeColors theme,
    required double width,
  }) {
    return CustomButton(
      text: 'previous_question'.tr(),
      onPressed: cubit.state.currentIndex > 0
          ? onPrevious
          : () => Navigator.of(context).pop(),
      width: width,
      height: math.max(44.0, 40.h),
      background: theme.background,
      foreground: theme.textPrimary,
      borderColor: theme.borderOff.withValues(alpha: 0.14),
      borderWidth: 0.5.w,
    );
  }

  Widget _nextButton({
    required BuildContext context,
    required AppThemeColors theme,
    required double width,
  }) {
    return CustomButton(
      text: 'continue'.tr(),
      onPressed: canGoNext ? () => _handleNext(context) : null,
      width: width,
      height: math.max(44.0, 40.h),
      background: canGoNext
          ? theme.primaryButton
          : theme.primaryButton.withValues(alpha: 0.5),
      foreground: AppColors.textUltraBlack,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeType = cubit.state.selectedThemeType ?? AppThemeType.normal;
    final theme = AppTheme.fromType(themeType);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth = constraints.maxWidth;

          if (availableWidth < 600) {
            final buttonWidth = (availableWidth - 12.w) / 2;

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (centerWidget != null) ...[
                  Center(child: centerWidget!),
                  verticalSpace(12),
                ],
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _previousButton(
                      context: context,
                      theme: theme,
                      width: buttonWidth,
                    ),
                    horizontalSpace(12),
                    _nextButton(
                      context: context,
                      theme: theme,
                      width: buttonWidth,
                    ),
                  ],
                ),
              ],
            );
          }

          final buttonWidth = math.min(230.w, availableWidth * 0.28);

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _previousButton(
                context: context,
                theme: theme,
                width: buttonWidth,
              ),
              horizontalSpace(16),
              Expanded(
                child: Center(child: centerWidget ?? const SizedBox.shrink()),
              ),
              horizontalSpace(16),
              _nextButton(context: context, theme: theme, width: buttonWidth),
            ],
          );
        },
      ),
    );
  }
}
