import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/features/questions/presentation/cubit/questions_cubit.dart';
import 'package:ya_perfume/features/questions/presentation/widgets/questions_widgets/question_background.dart';
import 'package:ya_perfume/features/questions/presentation/widgets/questions_widgets/question_body.dart';
import 'package:ya_perfume/features/questions/presentation/widgets/questions_widgets/question_footer.dart';
import 'package:ya_perfume/features/questions/presentation/widgets/questions_widgets/question_header.dart';

class QuestionsScreenContent extends StatelessWidget {
  const QuestionsScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionsCubit, QuestionsState>(
      builder: (context, state) {
        final cubit = context.read<QuestionsCubit>();
        final question = cubit.currentQuestion;
        final selectedOption = cubit.selectedOption;
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 64.w),
            child: Stack(
              children: [
                // الخلفية
                QuestionBackground(
                  backGroundColor:
                      selectedOption?.backGroundColor ??
                      question.initailBackGroundColor!,

                  primaryColor:
                      selectedOption?.primaryColor ??
                      question.initailPrimaryColor!,

                  secondaryColor:
                      selectedOption?.secondaryColor ??
                      question.initailSecondaryColor!,
                ),

                Column(
                  children: [
                    QuestionHeader(
                      currentIndex: state.currentIndex + 1,
                      totalQuestions: state.questions.length,
                    ),

                    QuestionBody(cubit: cubit),
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
