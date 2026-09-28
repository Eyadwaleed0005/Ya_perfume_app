import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
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
    /* if (cubit.currentQuestion.options.length < 3) {
      return buildDefaultOptions(context, theme);
    } */

    final firstOption = cubit.currentQuestion.options[0];
    final secondOption = cubit.currentQuestion.options[1];
    final thirdOption = cubit.currentQuestion.options[2];

    final hasSubtitles = cubit.currentQuestion.options.any(
      (option) => option.subtitle != null,
    );
    final optionHeight = hasSubtitles
        ? (availableHeight * 0.13).clamp(64.h, 96.h)
        : (availableHeight * 0.08).clamp(45.h, 72.h);
    final isArabic = context.locale.languageCode == 'ar';

    return Directionality(
      textDirection: isArabic ? ui.TextDirection.rtl : ui.TextDirection.ltr,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: optionHeight,
                  child: buildOption(
                    context: context,
                    option: firstOption,
                    theme: theme,
                  ),
                ),
              ),
              horizontalSpace(12),

              Expanded(
                child: SizedBox(
                  height: optionHeight,
                  child: buildOption(
                    context: context,
                    option: secondOption,
                    theme: theme,
                  ),
                ),
              ),
            ],
          ),

          verticalSpace(12),

          SizedBox(
            width: double.infinity,
            height: optionHeight,
            child: buildOption(
              context: context,
              option: thirdOption,
              theme: theme,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDefaultOptions(BuildContext context, AppThemeColors theme) {
    final crossAxisCount = cubit.currentQuestion.options.length >= 4 ? 2 : 1;

    final optionHeight = (availableHeight * 0.08).clamp(45.h, 72.h);
    final isArabic = context.locale.languageCode == 'ar';

    return Directionality(
      textDirection: isArabic ? ui.TextDirection.rtl : ui.TextDirection.ltr,

      child: GridView.count(
        shrinkWrap: false,
        physics: const BouncingScrollPhysics(),
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        mainAxisExtent: optionHeight,
        children: cubit.currentQuestion.options.map((option) {
          return buildOption(context: context, option: option, theme: theme);
        }).toList(),
      ),
    );
  }

  Widget buildOption({
    required BuildContext context,
    required QuestionOption option,
    required AppThemeColors theme,
  }) {
    final isSelected = cubit.state.selectedOptions.contains(option.id);
    final isArabic = context.locale.languageCode == 'ar';
    final isOptionTwo = option.id == '2' && cubit.currentQuestion.id == '4';

    return InkWell(
      onTap: () {
        cubit.toggleOption(option.id);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected
                  ? isOptionTwo
                        ? AppColors.blueSnow.withValues(alpha: 0.35)
                        : theme.borderOn
                  : theme.borderOff.withValues(alpha: 0.28),
              width: 0.5.w,
            ),
            borderRadius: BorderRadius.circular(16.r),
            color: isSelected
                ? isOptionTwo
                      ? AppColors.blueSnow.withValues(alpha: 0.25)
                      : theme.surfaceOn.withValues(alpha: 0.28)
                : theme.surfaceOff,
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
                  buildSelectionIndicator(isSelected, theme, isOptionTwo),
                  horizontalSpace(8),
                  Expanded(
                    child: Text(
                      option.text.tr(),
                      textDirection: isArabic
                          ? ui.TextDirection.rtl
                          : ui.TextDirection.ltr,
                      style: AppTextStyle.font18textPrimaryMediumNoto()
                          .copyWith(color: theme.textPrimary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              if (option.subtitle != null)
                Expanded(
                  child: Text(
                    option.subtitle!.tr(),
                    textDirection: isArabic
                        ? ui.TextDirection.rtl
                        : ui.TextDirection.ltr,
                    style: AppTextStyle.font15textMutedRegularNoto().copyWith(
                      color: theme.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
    AppThemeColors theme,
    bool isOptionTwo,
  ) {
    return AppAnimation.animatedSelectionIndicator(
      isSelected: isSelected,
      selectedWidget: Icon(
        Icons.circle,
        color: isOptionTwo
            ? AppColors.blueSnow.withValues(alpha: 0.45)
            : theme.primaryButton,
        size: 20.r,
      ),
      unselectedWidget: Icon(
        Icons.circle_outlined,
        color: theme.borderOff.withValues(alpha: 0.24),
        size: 20.r,
      ),
    );
  }
}
