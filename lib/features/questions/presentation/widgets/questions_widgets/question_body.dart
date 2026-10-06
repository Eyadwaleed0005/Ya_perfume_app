import 'package:flutter/material.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/theme/app_theme.dart';
import 'package:ya_perfume/core/theme/app_theme_colors.dart';
import 'package:ya_perfume/features/questions/presentation/cubit/questions_cubit.dart';
import 'package:ya_perfume/features/questions/presentation/widgets/questions_widgets/question_body_widgets/question_image.dart';
import 'package:ya_perfume/features/questions/presentation/widgets/questions_widgets/question_body_widgets/question_content.dart';

class QuestionBody extends StatelessWidget {
  final QuestionsCubit cubit;
  final QuestionsState state;
  const QuestionBody({super.key, required this.cubit, required this.state});

  @override
  Widget build(BuildContext context) {
    final question = cubit.currentQuestion;
    final selectedOption = cubit.selectedOption;
    AppThemeType themeType = state.selectedThemeType ?? AppThemeType.normal;
    AppThemeColors theme = AppTheme.fromType(themeType);
    final imagePath = selectedOption?.image ?? question.initailImage;

    final sh = MediaQuery.sizeOf(context).height;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        verticalSpace(20),

        QuestionImage(
          imagePath: imagePath,
          borderColor: theme.borderOn,
          cubit: cubit,
        ),

        horizontalSpace(16),

        QuestionContent(cubit: cubit, theme: theme, availableHeight: sh),
      ],
    );
  }
}
