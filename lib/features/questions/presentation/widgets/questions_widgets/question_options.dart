import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/style/textstyles.dart';
import 'package:ya_perfume/core/theme/app_theme.dart';
import 'package:ya_perfume/core/theme/app_theme_colors.dart';
import 'package:ya_perfume/features/questions/data/models/question_model.dart';
import 'package:ya_perfume/features/questions/presentation/cubit/questions_cubit.dart';

class QuestionOptions extends StatelessWidget {
  final QuestionsCubit cubit;

  const QuestionOptions({super.key, required this.cubit});

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

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 55.h,
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
                  height: 55.h,
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
            height: 55.h,
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

    return Directionality(
      textDirection: TextDirection.rtl,
      child: GridView.count(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        mainAxisExtent: 55.h,
        //childAspectRatio: crossAxisCount == 1 ? 660 / 84 : 325 / 84,
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
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected
                    ? theme.borderOn
                    : theme.borderOff.withValues(alpha: 0.28),
                width: 0.5,
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
    if (isSelected) {
      return Icon(Icons.circle, color: theme.primaryButton, size: 20.r);
    }

    return Icon(
      Icons.circle_outlined,
      color: theme.borderOff.withValues(alpha: 0.24),
      size: 20.r,
    );
  }
}
