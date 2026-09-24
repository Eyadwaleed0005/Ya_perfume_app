import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/core/style/textstyles.dart';
import 'package:ya_perfume/features/questions/presentation/widgets/questions_widgets/question_progress.dart';

class QuestionHeader extends StatelessWidget {
  final int currentIndex;
  final int totalQuestions;

  const QuestionHeader({
    super.key,
    required this.currentIndex,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'YA  PERFUME',
            textAlign: TextAlign.center,
            style: AppTextStyle.font18TextAccentMediumNoto(),
          ),

          QuestionProgress(
            currentIndex: currentIndex - 1,
            totalQuestions: totalQuestions,
          ),

          Text(
            'السؤال $currentIndex من $totalQuestions',
            textAlign: TextAlign.center,
            style: AppTextStyle.font16textMutedMediumNoto(),
          ),
        ],
      ),
    );
  }
}
