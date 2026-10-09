import 'package:flutter/material.dart';
import 'package:ya_perfume/core/theme/app_theme.dart';
import 'package:ya_perfume/features/questions/presentation/cubit/questions_cubit.dart';
import 'package:ya_perfume/features/questions/presentation/widgets/questions_widgets/question_body_widgets/question_options_widgets.dart';

class QuestionOptions extends StatelessWidget {
  final QuestionsCubit cubit;
  final double? availableHeight;

  const QuestionOptions({super.key, required this.cubit, this.availableHeight});

  @override
  Widget build(BuildContext context) {
    final themeType = cubit.state.selectedThemeType ?? AppThemeType.normal;
    final theme = AppTheme.fromType(themeType);

    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : availableHeight ?? 400.0;

        final questionOptions = QuestionOptionsWidgets(
          cubit: cubit,
          availableHeight: height,
        );

        if (cubit.currentQuestion.id == '4') {
          return questionOptions.buildQuestionFour(context, theme);
        }

        return questionOptions.buildDefaultOptions(context, theme);
      },
    );
  }
}
