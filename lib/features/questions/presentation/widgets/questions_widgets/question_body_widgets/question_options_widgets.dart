import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ya_perfume/app/routes/app_images_routes.dart';
import 'package:ya_perfume/core/animation/app_animation.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/style/textstyles.dart';
import 'package:ya_perfume/core/theme/app_theme_colors.dart';
import 'package:ya_perfume/features/questions/data/models/question_model.dart';
import 'package:ya_perfume/features/questions/presentation/cubit/questions_cubit.dart';

class QuestionOptionsWidgets {
  final QuestionsCubit cubit;
  final double availableHeight;

  QuestionOptionsWidgets({required this.cubit, required this.availableHeight});

  Widget buildQuestionFour(BuildContext context, AppThemeColors theme) {
    final options = cubit.currentQuestion.options;

    if (options.length != 3) {
      return buildDefaultOptions(context, theme);
    }

    return Directionality(
      textDirection: _textDirection(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildRow(
            context: context,
            theme: theme,
            options: options.take(2).toList(),
          ),
          SizedBox(height: 12.h),
          buildOption(context: context, option: options[2], theme: theme),
        ],
      ),
    );
  }

  Widget buildDefaultOptions(BuildContext context, AppThemeColors theme) {
    final options = cubit.currentQuestion.options;

    if (options.isEmpty) {
      return const SizedBox.shrink();
    }

    return Directionality(
      textDirection: _textDirection(context),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = options.length >= 4 && constraints.maxWidth >= 320
              ? 2
              : 1;

          final rows = <Widget>[];

          for (var index = 0; index < options.length; index += columns) {
            if (rows.isNotEmpty) {
              rows.add(SizedBox(height: 12.h));
            }

            final end = index + columns > options.length
                ? options.length
                : index + columns;

            rows.add(
              _buildRow(
                context: context,
                theme: theme,
                options: options.sublist(index, end),
                columns: columns,
              ),
            );
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: rows,
          );
        },
      ),
    );
  }

  ui.TextDirection _textDirection(BuildContext context) {
    return context.locale.languageCode == 'ar'
        ? ui.TextDirection.rtl
        : ui.TextDirection.ltr;
  }

  Widget _buildRow({
    required BuildContext context,
    required AppThemeColors theme,
    required List<QuestionOption> options,
    int columns = 2,
  }) {
    if (columns == 1) {
      return buildOption(context: context, option: options.first, theme: theme);
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: buildOption(
              context: context,
              option: options.first,
              theme: theme,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: options.length > 1
                ? buildOption(
                    context: context,
                    option: options[1],
                    theme: theme,
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget buildOption({
    required BuildContext context,
    required QuestionOption option,
    required AppThemeColors theme,
    double? optionHeight,
  }) {
    final isSelected = cubit.state.selectedOptions.contains(option.id);
    final isArabic = context.locale.languageCode == 'ar';
    final textDirection = _textDirection(context);

    final isOptionTwo = option.id == '2' && cubit.currentQuestion.id == '4';
    final showFrostCover = isOptionTwo && isSelected;

    final subtitle = option.subtitle?.tr();
    final hasSubtitle = subtitle != null && subtitle.trim().isNotEmpty;

    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: () => cubit.toggleOption(option.id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        constraints: BoxConstraints(minHeight: 64.h),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border.all(
            color: showFrostCover
                ? AppColors.borderSnow.withValues(alpha: 0.68)
                : isSelected
                ? theme.borderOn
                : theme.borderOff.withValues(alpha: 0.28),
            width: 0.5.w,
          ),
          borderRadius: BorderRadius.circular(16.r),
          color: showFrostCover
              ? AppColors.blueSnow
              : isSelected
              ? theme.surfaceOn.withValues(alpha: 0.28)
              : theme.surfaceOff,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (isOptionTwo) FrostCover(isVisible: showFrostCover),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Row(
                textDirection: textDirection,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildSelectionIndicator(isSelected, theme, size: 20.r),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          option.text.tr(),
                          textDirection: textDirection,
                          textAlign: isArabic
                              ? TextAlign.right
                              : TextAlign.left,
                          style: AppTextStyle.font18textPrimaryMediumNoto()
                              .copyWith(
                                color: showFrostCover
                                    ? AppColors.textSecondary
                                    : theme.textPrimary,
                              ),
                        ),
                        if (hasSubtitle) ...[
                          SizedBox(height: 4.h),
                          Text(
                            subtitle,
                            textDirection: textDirection,
                            textAlign: isArabic
                                ? TextAlign.right
                                : TextAlign.left,
                            style: AppTextStyle.font15textMutedRegularNoto()
                                .copyWith(color: theme.textSecondary),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildSelectionIndicator(
    bool isSelected,
    AppThemeColors theme, {
    double? size,
  }) {
    final iconSize = size ?? 20.r;

    return AppAnimation.animatedSelectionIndicator(
      isSelected: isSelected,
      selectedWidget: Icon(
        Icons.circle,
        color: theme.primaryButton,
        size: iconSize,
      ),
      unselectedWidget: Icon(
        Icons.circle_outlined,
        color: theme.borderOff.withValues(alpha: 0.24),
        size: iconSize,
      ),
    );
  }
}

class FrostCover extends StatelessWidget {
  final bool isVisible;

  const FrostCover({super.key, required this.isVisible});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: AnimatedOpacity(
          opacity: isVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: SvgPicture.asset(
              AppImage().naturalFrostQ4,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
