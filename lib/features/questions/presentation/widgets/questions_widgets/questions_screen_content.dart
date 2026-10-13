import 'dart:async';
import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snowfall_or_anythings/snowfall_or_anythings.dart';
import 'package:ya_perfume/app/routes/route_names.dart';
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

class QuestionsScreenContent extends StatefulWidget {
  const QuestionsScreenContent({super.key});

  @override
  State<QuestionsScreenContent> createState() => _QuestionsScreenContentState();
}

class _QuestionsScreenContentState extends State<QuestionsScreenContent> {
  static const Set<String> _multipleChoiceQuestionIds = {'5', '6'};

  static const Duration _autoNextDelay = Duration(milliseconds: 500);

  Timer? _autoNextTimer;

  late int _lastQuestionIndex;
  late bool _showContinueForSavedAnswer;

  @override
  void initState() {
    super.initState();

    final state = context.read<QuestionsCubit>().state;

    _lastQuestionIndex = state.currentIndex;
    _showContinueForSavedAnswer = state.selectedOptions.isNotEmpty;
  }

  bool _isMultipleChoice(String questionId) {
    return _multipleChoiceQuestionIds.contains(questionId);
  }

  void _cancelAutoNext() {
    _autoNextTimer?.cancel();
    _autoNextTimer = null;
  }

  @override
  void dispose() {
    _cancelAutoNext();
    super.dispose();
  }

  void _handleNext(QuestionsCubit cubit) {
    _cancelAutoNext();

    if (!cubit.canContinue) {
      return;
    }

    final questionId = cubit.currentQuestion.id;

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

    cubit.next();
  }

  void _handlePrevious(QuestionsCubit cubit) {
    _cancelAutoNext();
    cubit.previous();
  }

  void _handleSkip(QuestionsCubit cubit) {
    _cancelAutoNext();
    cubit.skip();
  }

  void _scheduleAutoNext(QuestionsCubit cubit, QuestionsState state) {
    _cancelAutoNext();

    final questionId = cubit.currentQuestion.id;
    if (_showContinueForSavedAnswer ||
        _isMultipleChoice(questionId) ||
        state.selectedOptions.isEmpty ||
        !cubit.canContinue) {
      return;
    }

    final scheduledIndex = state.currentIndex;
    final scheduledSelection = state.selectedOptions.toSet();

    _autoNextTimer = Timer(_autoNextDelay, () {
      _autoNextTimer = null;

      if (!mounted || cubit.isClosed) {
        return;
      }

      if (ModalRoute.of(context)?.isCurrent != true) {
        return;
      }

      final currentState = cubit.state;

      if (_showContinueForSavedAnswer ||
          currentState.currentIndex != scheduledIndex ||
          cubit.currentQuestion.id != questionId) {
        return;
      }

      final selectionUnchanged =
          currentState.selectedOptions.length == scheduledSelection.length &&
          currentState.selectedOptions.every(scheduledSelection.contains);

      if (!selectionUnchanged ||
          currentState.selectedOptions.isEmpty ||
          !cubit.canContinue) {
        return;
      }

      _handleNext(cubit);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuestionsCubit, QuestionsState>(
      listenWhen: (previous, current) {
        final questionChanged = previous.currentIndex != current.currentIndex;

        final selectionChanged =
            previous.selectedOptions.length != current.selectedOptions.length ||
            current.selectedOptions.any(
              (id) => !previous.selectedOptions.contains(id),
            );

        return questionChanged || selectionChanged;
      },
      listener: (context, state) {
        final cubit = context.read<QuestionsCubit>();

        if (_lastQuestionIndex != state.currentIndex) {
          _cancelAutoNext();

          setState(() {
            _lastQuestionIndex = state.currentIndex;

            _showContinueForSavedAnswer = state.selectedOptions.isNotEmpty;
          });

          return;
        }

        _scheduleAutoNext(cubit, state);
      },
      builder: (context, state) {
        final effectiveThemeType =
            state.selectedThemeType ?? AppThemeType.normal;

        final theme = AppTheme.fromType(effectiveThemeType);
        final cubit = context.read<QuestionsCubit>();
        final questionId = cubit.currentQuestion.id;

        final showSnow =
            questionId == '4' && state.selectedOptions.contains('2');

        final showNextButton =
            _isMultipleChoice(questionId) || _showContinueForSavedAnswer;

        final centerWidget = _buildCenterWidget(
          context: context,
          questionId: questionId,
          numberSelected: state.selectedOptions.length,
          onSkip: () => _handleSkip(cubit),
          theme: theme,
        );

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
                                questionId: questionId,
                                canGoNext: cubit.canContinue,
                                showNextButton: showNextButton,
                                onNext: () => _handleNext(cubit),
                                onPrevious: () => _handlePrevious(cubit),
                                onSkip: () => _handleSkip(cubit),
                                cubit: cubit,
                                centerWidget: centerWidget,
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

  Widget? _buildCenterWidget({
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

    return null;
  }
}
