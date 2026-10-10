import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class QuestionsScreenContent extends StatelessWidget {
  const QuestionsScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionsCubit, QuestionsState>(
      builder: (context, state) {
        final effectiveThemeType =
            state.selectedThemeType ?? AppThemeType.normal;

        final theme = AppTheme.fromType(effectiveThemeType);
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
                      key: const ValueKey('question-4-option-2-snow'),
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

            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              verticalSpace(16),
                              QuestionHeader(
                                currentIndex: state.currentIndex + 1,
                                totalQuestions: state.questions.length,
                                state: state,
                              ),
                              verticalSpace(16),
                              QuestionBody(cubit: cubit, state: state),
                              verticalSpace(24),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomFooter(
                                numberSelected: state.selectedOptions.length,
                                questionId: cubit.currentQuestion.id,
                                canGoNext: cubit.canContinue,
                                onNext: () => cubit.next(),
                                onPrevious: () => cubit.previous(),
                                onSkip: () => cubit.skip(),
                                cubit: cubit,
                                centerWidget: _buildCenterWidget(
                                  context: context,
                                  questionId: cubit.currentQuestion.id,
                                  numberSelected: state.selectedOptions.length,
                                  onSkip: cubit.skip,
                                  theme: theme,
                                ),
                              ),
                              verticalSpace(16),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCenterWidget({
    required BuildContext context,
    required String questionId,
    required int numberSelected,
    required VoidCallback onSkip,
    required AppThemeColors theme,
  }) {
    final isArabic = context.locale.languageCode == 'ar';

    if (questionId == '5') {
      return Text(
        'selected_families_count'.tr(args: ['$numberSelected']),
        style: AppTextStyle.font15textMutedMediumNoto().copyWith(
          color: theme.textSecondary,
        ),
        textAlign: TextAlign.center,
        textDirection: isArabic ? ui.TextDirection.rtl : ui.TextDirection.ltr,
      );
    }

    if (questionId == '6') {
      return InkWell(
        onTap: onSkip,
        child: Text(
          'skip_question'.tr(),
          style: AppTextStyle.font17textAccentUnderLineMediumNoto().copyWith(
            color: theme.title,
            decorationColor: theme.title,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
