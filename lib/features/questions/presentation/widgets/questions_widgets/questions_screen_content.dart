import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snowfall_or_anythings/snowfall_or_anythings.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/theme/app_theme.dart';
import 'package:ya_perfume/core/theme/app_theme_colors.dart';
import 'package:ya_perfume/core/widgets/question_background.dart';
import 'package:ya_perfume/core/widgets/question_footer.dart';
import 'package:ya_perfume/features/questions/presentation/cubit/questions_cubit.dart';
import 'package:ya_perfume/features/questions/presentation/widgets/questions_widgets/question_body.dart';
import 'package:ya_perfume/features/questions/presentation/widgets/questions_widgets/question_header.dart';

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
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 64.w),
            child: Stack(
              children: [
                QuestionBackground(
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
                          particleColor:
                              effectiveThemeType == AppThemeType.light
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
                    QuestionHeader(
                      currentIndex: state.currentIndex + 1,
                      totalQuestions: state.questions.length,
                      state: state,
                    ),

                    QuestionBody(cubit: cubit, state: state),
                  ],
                ),

                //bottom Navigation
                QuestionFooter(
                  numberSelected: state.selectedOptions.length,
                  questionId: cubit.currentQuestion.id,
                  canGoNext: cubit.canContinue,
                  onNext: () => cubit.next(),
                  onPrevious: () => cubit.previous(),
                  onSkip: () => cubit.skip(),
                  state: state,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
