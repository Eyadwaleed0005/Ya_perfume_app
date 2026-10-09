import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/theme/app_theme.dart';
import 'package:ya_perfume/features/questions/presentation/cubit/questions_cubit.dart';
import 'package:ya_perfume/features/questions/presentation/widgets/questions_widgets/question_body_widgets/question_image.dart';
import 'package:ya_perfume/features/questions/presentation/widgets/questions_widgets/question_body_widgets/question_content.dart';

class QuestionBody extends StatelessWidget {
  final QuestionsCubit cubit;
  final QuestionsState state;

  const QuestionBody({
    super.key,
    required this.cubit,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final question = cubit.currentQuestion;
    final selectedOption = cubit.selectedOption;
    final themeType = state.selectedThemeType ?? AppThemeType.normal;
    final theme = AppTheme.fromType(themeType);
    final imagePath = selectedOption?.image ?? question.initailImage;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final availableHeight = constraints.maxHeight.isFinite
              ? constraints.maxHeight
              : MediaQuery.sizeOf(context).height;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QuestionImage(
                imagePath: imagePath,
                borderColor: theme.borderOn,
                cubit: cubit,
              ),
              horizontalSpace(16),
              QuestionContent(
                cubit: cubit,
                theme: theme,
                availableHeight: availableHeight,
              ),
            ],
          );
        },
      ),
    );
  }
}