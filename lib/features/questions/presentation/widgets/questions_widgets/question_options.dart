import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/core/animation/app_animation.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/textstyles.dart';
import 'package:ya_perfume/core/theme/app_theme.dart';
import 'package:ya_perfume/core/theme/app_theme_colors.dart';
import 'package:ya_perfume/features/questions/data/models/question_model.dart';
import 'package:ya_perfume/features/questions/presentation/cubit/questions_cubit.dart';

class QuestionOptions extends StatelessWidget {
  final QuestionsCubit cubit;

  /// Available height passed from the parent so that [mainAxisExtent]
  /// and option heights can be calculated proportionally instead of
  /// being hardcoded.
  final double availableHeight;

  const QuestionOptions({
    super.key,
    required this.cubit,
    required this.availableHeight,
  });

  @override
  Widget build(BuildContext context) {
    AppThemeType themeType =
        cubit.state.selectedThemeType ?? AppThemeType.normal;
    AppThemeColors theme = AppTheme.fromType(themeType);

    if (cubit.currentQuestion.id == '4') {
      return _buildQuestionFour(context, theme);
    }

    return _buildDefaultOptions(context, theme);
  }

  Widget _buildQuestionFour(BuildContext context, AppThemeColors theme) {
    if (cubit.currentQuestion.options.length < 3) {
      return _buildDefaultOptions(context, theme);
    }

    final firstOption = cubit.currentQuestion.options[0];
    final secondOption = cubit.currentQuestion.options[1];
    final thirdOption = cubit.currentQuestion.options[2];

    // Proportional height: ~8% of available content height, clamped sensibly
    final optionHeight = (availableHeight * 0.08).clamp(45.0, 72.0);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: optionHeight,
                  child: _buildOption(
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
                  child: _buildOption(
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
            child: _buildOption(
              context: context,
              option: thirdOption,
              theme: theme,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultOptions(BuildContext context, AppThemeColors theme) {
    final crossAxisCount = cubit.currentQuestion.options.length >= 4 ? 2 : 1;

    // Proportional mainAxisExtent: ~8% of available height, clamped
    final optionHeight = (availableHeight * 0.08).clamp(45.0, 72.0);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: GridView.count(
        // RULE 3: Never use shrinkWrap: true inside Expanded
        shrinkWrap: false,
        physics: const BouncingScrollPhysics(),
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        // RULE 4: mainAxisExtent calculated proportionally, never hardcoded
        mainAxisExtent: optionHeight,
        children: cubit.currentQuestion.options.map((option) {
          return _buildOption(context: context, option: option, theme: theme);
        }).toList(),
      ),
    );
  }

  Widget _buildOption({
    required BuildContext context,
    required QuestionOption option,
    required AppThemeColors theme,
  }) {
    final isSelected = cubit.state.selectedOptions.contains(option.id);

    return InkWell(
          onTap: () {
            context.read<QuestionsCubit>().toggleOption(option.id);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected
                    ? theme.borderOn
                    : theme.borderOff.withValues(alpha: 0.28),
                // RULE 1: border width must scale
                width: 0.5.w,
              ),
              borderRadius: BorderRadius.circular(16.r),
              color: isSelected
                  ? theme.surfaceOn.withValues(alpha: 0.28)
                  : theme.surfaceOff,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildSelectionIndicator(isSelected, theme),
                horizontalSpace(8),
                Expanded(
                  child: Text(
                    option.text,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.start,
                    // RULE 6 removed per user request — AppTextStyle.sp is enough
                    style: AppTextStyle.font18textPrimaryMediumNoto().copyWith(
                      color: theme.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 350.ms)
        .slideY(begin: 0.08, end: 0, duration: 400.ms);
  }

  Widget _buildSelectionIndicator(bool isSelected, AppThemeColors theme) {
    return AppAnimation.animatedSelectionIndicator(
      isSelected: isSelected,
      selectedWidget: Icon(
        Icons.circle,
        color: theme.primaryButton,
        // RULE 7: Icons use .r
        size: 20.r,
      ),
      unselectedWidget: Icon(
        Icons.circle_outlined,
        color: theme.borderOff.withValues(alpha: 0.24),
        // RULE 7: Icons use .r
        size: 20.r,
      ),
    );
  }
}
