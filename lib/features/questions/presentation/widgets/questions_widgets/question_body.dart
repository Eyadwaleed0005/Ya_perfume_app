import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ya_perfume/app/routes/route_names.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/textstyles.dart';
import 'package:ya_perfume/features/questions/presentation/cubit/questions_cubit.dart';
import 'package:ya_perfume/features/questions/presentation/widgets/questions_widgets/question_options.dart';

class QuestionBody extends StatelessWidget {
  final QuestionsCubit cubit;
  const QuestionBody({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final question = cubit.currentQuestion;
    final selectedOption = cubit.selectedOption;
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          verticalSpace(20),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(color: Colors.transparent),

              child: SvgPicture.asset(
                selectedOption?.image ?? question.initailImage!,
                alignment: Alignment.topCenter,
                fit: BoxFit.contain,
              ),
            ),
          ),

          horizontalSpace(16),

          Expanded(
            flex: 2,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              layoutBuilder: (currentChild, previousChildren) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    ...previousChildren,
                    if (currentChild != null) currentChild,
                  ],
                );
              },
              child: Column(
                key: ValueKey(cubit.currentQuestion.id),
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  verticalSpace(8),
                  Text(
                    cubit.currentQuestion.title,
                    style: AppTextStyle.font15textAccentRegularNoto(),
                    textAlign: TextAlign.right,
                  ),

                  verticalSpace(16),

                  Text(
                    cubit.currentQuestion.questionText,
                    style: AppTextStyle.font34textPrimarySemiBoldNoto(),
                    textAlign: TextAlign.right,
                  ),

                  verticalSpace(16),

                  Text(
                    cubit.currentQuestion.note,
                    style: AppTextStyle.font17textMutedRegularNoto(),
                    textAlign: TextAlign.right,
                  ),

                  verticalSpace(8),

                  Expanded(
                    child: QuestionOptions(
                      options: cubit.currentQuestion.options,
                      selectedOptions: cubit.state.selectedOptions,
                      questionData: cubit.currentQuestion,
                    ),
                  ),

                  if (cubit.currentQuestion.id == '5') ...[
                    verticalSpace(16),

                    InkWell(
                      onTap: () {
                        if (cubit.state.families.isEmpty) {
                          return;
                        }

                        Navigator.of(context).pushNamed(
                          RouteNames.fragranceFamilies,
                          arguments: cubit.state.families,
                        );
                      },
                      child: Text(
                        'تعرف على الفروق بين العائلات العطرية',
                        style:
                            AppTextStyle.font16textAccentUnderLineMediumNoto(),
                        textAlign: TextAlign.right,
                      ),
                    ),

                    verticalSpace(8),

                    cubit.state.showInfo
                        ? Text(
                            '.يمكنك اختيار عائلتين كحد أقصى. ألغِ أحد الاختيارات لإضافة عائلة أخرى',
                            style: AppTextStyle.font16textAccentMediumNoto(),
                            textAlign: TextAlign.right,
                          )
                        : const SizedBox.shrink(),
                  ],

                  verticalSpace(80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
