import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ya_perfume/app/routes/app_images_routes.dart';
import 'package:ya_perfume/core/animation/app_animation.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
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
    final firstOption = cubit.currentQuestion.options[0];
    final secondOption = cubit.currentQuestion.options[1];
    final thirdOption = cubit.currentQuestion.options[2];

    final spacing = (availableHeight * 0.05).clamp(6.0, 12.h);
    final topSpacing = (availableHeight * 0.03).clamp(4.0, 12.h);
    final optionHeight = (availableHeight - topSpacing - spacing) / 2;
    final isArabic = context.locale.languageCode == 'ar';

    return Directionality(
      textDirection: isArabic ? ui.TextDirection.rtl : ui.TextDirection.ltr,
      child: Column(
        children: [
          SizedBox(height: topSpacing),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: optionHeight,
                  child: buildOption(
                    context: context,
                    option: firstOption,
                    theme: theme,
                    optionHeight: optionHeight,
                  ),
                ),
              ),
              horizontalSpace(12.w),
              Expanded(
                child: SizedBox(
                  height: optionHeight,
                  child: buildOption(
                    context: context,
                    option: secondOption,
                    theme: theme,
                    optionHeight: optionHeight,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spacing),
          SizedBox(
            width: double.infinity,
            height: optionHeight,
            child: buildOption(
              context: context,
              option: thirdOption,
              theme: theme,
              optionHeight: optionHeight,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDefaultOptions(BuildContext context, AppThemeColors theme) {
    final options = cubit.currentQuestion.options;
    final optionsLength = options.length;
    final crossAxisCount = optionsLength >= 4 ? 2 : 1;
    final rowCount = (optionsLength / crossAxisCount).ceil();
    final isArabic = context.locale.languageCode == 'ar';

    final mainAxisSpacing = rowCount > 1
        ? (availableHeight * 0.035).clamp(4.0, 12.h)
        : 0.0;
    final totalSpacing = (rowCount - 1) * mainAxisSpacing;
    final optionHeight = (availableHeight - totalSpacing) / rowCount;

    return Directionality(
      textDirection: isArabic ? ui.TextDirection.rtl : ui.TextDirection.ltr,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: optionsLength,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: mainAxisSpacing,
          mainAxisExtent: optionHeight,
        ),
        itemBuilder: (context, index) {
          final option = options[index];
          return buildOption(
            context: context,
            option: option,
            theme: theme,
            optionHeight: optionHeight,
          );
        },
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
    final isOptionTwo = option.id == '2' && cubit.currentQuestion.id == '4';
    final showFrostCover = isOptionTwo && isSelected;
    final verticalPadding = optionHeight != null
        ? (optionHeight * 0.08).clamp(2.0, 6.h)
        : 6.h;
    final indicatorSize = optionHeight != null
        ? (optionHeight * 0.35).clamp(14.r, 20.r)
        : 20.r;

    return InkWell(
      onTap: () {
        cubit.toggleOption(option.id);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
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
            children: [
              if (isOptionTwo) FrostCover(isVisible: showFrostCover),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: verticalPadding,
                ),
                child: Column(
                  textDirection: isArabic
                      ? ui.TextDirection.rtl
                      : ui.TextDirection.ltr,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      textDirection: isArabic
                          ? ui.TextDirection.rtl
                          : ui.TextDirection.ltr,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildSelectionIndicator(
                          isSelected,
                          theme,
                          size: indicatorSize,
                        ),
                        horizontalSpace(8.w),
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: isArabic
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Text(
                              option.text.tr(),
                              textDirection: isArabic
                                  ? ui.TextDirection.rtl
                                  : ui.TextDirection.ltr,
                              style: AppTextStyle.font18textPrimaryMediumNoto()
                                  .copyWith(
                                    color: showFrostCover
                                        ? AppColors.textSecondary
                                        : theme.textPrimary,
                                  ),
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (option.subtitle != null) ...[
                      SizedBox(
                        height: optionHeight != null
                            ? (optionHeight * 0.04).clamp(1.0, 4.h)
                            : 2.h,
                      ),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: isArabic
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Text(
                            option.subtitle!.tr(),
                            textDirection: isArabic
                                ? ui.TextDirection.rtl
                                : ui.TextDirection.ltr,
                            style: AppTextStyle.font15textMutedRegularNoto()
                                .copyWith(color: theme.textSecondary),
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
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
      child: AnimatedOpacity(
        opacity: isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: SvgPicture.asset(AppImage().naturalFrostQ4, fit: BoxFit.fill),
        ),
      ),
    );
  }
}
