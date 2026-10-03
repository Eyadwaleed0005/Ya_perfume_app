import 'package:flutter/material.dart';
import 'package:ya_perfume/core/theme/app_theme.dart';
import 'package:ya_perfume/core/theme/app_theme_colors.dart';
import 'package:ya_perfume/features/questions/presentation/cubit/questions_cubit.dart';
import 'package:ya_perfume/features/questions/presentation/widgets/questions_widgets/question_body_widgets/question_options_widgets.dart';

class QuestionOptions extends StatelessWidget {
  final QuestionsCubit cubit;
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
    final quesOptions = QuestionOptionsWidgets(
      cubit: cubit,
      availableHeight: availableHeight,
    );

    if (cubit.currentQuestion.id == '4') {
      return quesOptions.buildQuestionFour(context, theme);
    }

    return quesOptions.buildDefaultOptions(context, theme);
  }
}
