import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/app/routes/route_names.dart';
import 'package:ya_perfume/core/animation/app_animation.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/textstyles.dart';
import 'package:ya_perfume/core/theme/app_theme_colors.dart';
import 'package:ya_perfume/features/questions/presentation/cubit/questions_cubit.dart';
import 'package:ya_perfume/features/questions/presentation/widgets/questions_widgets/question_options.dart';

class QuestionContent extends StatelessWidget {
  final QuestionsCubit cubit;
  final AppThemeColors theme;

  /// Available height of the content area, passed from the parent screen
  /// (which reads MediaQuery once). This avoids nesting a LayoutBuilder here.
  final double availableHeight;

  const QuestionContent({
    super.key,
    required this.cubit,
    required this.theme,
    required this.availableHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: AppAnimation.animatedContentSwitcher(
        child: Column(
          key: ValueKey(cubit.currentQuestion.id),
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            verticalSpace(8),
            Text(
              cubit.currentQuestion.title,
              style: AppTextStyle.font15textAccentRegularNoto().copyWith(
                color: theme.title,
              ),
              textAlign: TextAlign.right,
            ),
            verticalSpace(16),
            Text(
              cubit.currentQuestion.questionText,
              style: AppTextStyle.font34textPrimarySemiBoldNoto().copyWith(
                color: theme.textPrimary,
              ),
              textAlign: TextAlign.right,
            ),
            verticalSpace(16),
            Text(
              cubit.currentQuestion.note,
              style: AppTextStyle.font17textMutedRegularNoto().copyWith(
                color: theme.textSecondary,
              ),
              textAlign: TextAlign.right,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: QuestionOptions(
                  cubit: cubit,
                  availableHeight: availableHeight,
                ),
              ),
            ),
            if (cubit.currentQuestion.id == '5') ...[
              verticalSpace(8),
              InkWell(
                onTap: () {
                  if (cubit.state.families.isEmpty) {
                    return;
                  }
                  Navigator.of(context).pushNamed(
                    RouteNames.fragranceFamilies,
                    arguments: {
                      'families': cubit.state.families,
                      'themeType': cubit.state.selectedThemeType,
                    },
                  );
                },
                child: Text(
                  'تعرف على الفروق بين العائلات العطرية',
                  style: AppTextStyle.font16textAccentUnderLineMediumNoto()
                      .copyWith(
                        color: theme.title,
                        decorationColor: theme.title,
                      ),
                  textAlign: TextAlign.right,
                ),
              ),
              verticalSpace(8),
              cubit.state.showInfo
                  ? Text(
                      '.يمكنك اختيار عائلتين كحد أقصى. ألغِ أحد الاختيارات لإضافة عائلة أخرى',
                      style: AppTextStyle.font16textAccentMediumNoto().copyWith(
                        color: theme.title,
                      ),
                      textAlign: TextAlign.right,
                    )
                  : const SizedBox.shrink(),
            ],
            // Proportional bottom padding — avoids hardcoded 80
            SizedBox(height: (availableHeight * 0.14)),
          ],
        ),
      ),
    );
  }
}
