import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/core/style/textstyles.dart';
import 'package:ya_perfume/core/theme/app_theme.dart';
import 'package:ya_perfume/core/theme/app_theme_colors.dart';
import 'package:ya_perfume/features/questions/presentation/cubit/questions_cubit.dart';
import 'package:ya_perfume/features/questions/presentation/widgets/questions_widgets/question_progress.dart';

class QuestionHeader extends StatelessWidget {
  final int currentIndex;
  final int totalQuestions;
  final QuestionsState state;

  const QuestionHeader({
    super.key,
    required this.currentIndex,
    required this.totalQuestions,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    AppThemeType themeType = state.selectedThemeType ?? AppThemeType.normal;
    AppThemeColors theme = AppTheme.fromType(themeType);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'YA  PERFUME',
            textAlign: TextAlign.center,
            style: AppTextStyle.font18TextAccentMediumNoto().copyWith(
              color: theme.title,
            ),
          ),

          QuestionProgress(
            currentIndex: currentIndex - 1,
            totalQuestions: totalQuestions,
          ),

          Text(
            'السؤال $currentIndex من $totalQuestions',
            textAlign: TextAlign.center,
            style: AppTextStyle.font16textMutedMediumNoto().copyWith(
              color: theme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
