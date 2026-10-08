import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snowfall_or_anythings/snowfall_or_anythings.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/style/textstyles.dart';
import 'package:ya_perfume/core/theme/app_theme.dart';
import 'package:ya_perfume/core/theme/app_theme_colors.dart';
import 'package:ya_perfume/core/widgets/custom_background.dart';
import 'package:ya_perfume/core/widgets/custom_footer.dart';
import 'package:ya_perfume/features/questions/presentation/cubit/questions_cubit.dart';
import 'package:ya_perfume/features/questions/presentation/widgets/questions_widgets/question_body.dart';
import 'package:ya_perfume/features/questions/presentation/widgets/questions_widgets/question_header.dart';

import 'dart:ui' as ui;

class QuestionsScreenContent extends StatelessWidget {
  const QuestionsScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionsCubit, QuestionsState>(
      builder: (context, state) {
        AppThemeType effectiveThemeType =
            state.selectedThemeType ?? AppThemeType.normal;
        AppThemeColors theme = AppTheme.fromType(effectiveThemeType);
        final cubit = context.read<QuestionsCubit>();
        final showSnow =
            cubit.currentQuestion.id == '4' &&
            state.selectedOptions.contains('2');
        return Stack(
          fit: StackFit.expand,
          children: [
            CustomBackground(
              backGroundColor: theme.background,
              primaryColor: theme.primary.withValues(alpha: 0.14),
              secondaryColor: theme.secondary,
            ),

            if (showSnow)
              Positioned.fill(
                child: IgnorePointer(
                  child: RepaintBoundary(
                    child: SnowfallOrAnythings(
                      key: const ValueKey('question-3-option-2-snow'),
                      numberOfParticles: 50,
                      particleSize: 1,
                      particleSpeed: 0.40,
                      particleColor: effectiveThemeType == AppThemeType.light
                          ? AppColors.blueSnow.withValues(alpha: 0.25)
                          : AppColors.whiteSnow.withValues(alpha: 0.8),
                      particleType: ParticleType.snowflake,
                      frameRateMs: 60,
                    ),
                  ),
                ),
              ),

            Column(
              children: [
                verticalSpace(16.h),
                QuestionHeader(
                  currentIndex: state.currentIndex + 1,
                  totalQuestions: state.questions.length,
                  state: state,
                ),

                Expanded(
                  child: QuestionBody(cubit: cubit, state: state),
                ),
                CustomFooter(
                  numberSelected: state.selectedOptions.length,
                  questionId: cubit.currentQuestion.id,
                  canGoNext: cubit.canContinue,
                  onNext: () => cubit.next(),
                  onPrevious: () => cubit.previous(),
                  onSkip: () => cubit.skip(),
                  cubit: cubit,
                  centerWidget: _buildCenterWidget(
                    cubit.currentQuestion.id,
                    state.selectedOptions.length,
                    cubit.skip,
                    theme,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildCenterWidget(
    String questionId,
    int numberSelected,
    Function() onSkip,
    AppThemeColors theme,
  ) {
    if (questionId == '5') {
      return Text(
        'selected_families_count'.tr(args: ['$numberSelected']),
        style: AppTextStyle.font15textMutedMediumNoto().copyWith(
          color: theme.textSecondary,
        ),
        textAlign: TextAlign.center,
        textDirection: ui.TextDirection.rtl,
      );
    }
    if (questionId == '6') {
      return InkWell(
        onTap: onSkip,
        child: Text(
          'skip_question'.tr(),
          style: AppTextStyle.font17textAccentUnderLineMediumNoto()
              .copyWith(color: theme.title, decorationColor: theme.title)
              .copyWith(color: theme.title, decorationColor: theme.title),
          textAlign: TextAlign.right,
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
