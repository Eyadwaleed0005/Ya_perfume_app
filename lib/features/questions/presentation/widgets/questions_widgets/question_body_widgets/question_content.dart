import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ya_perfume/app/routes/route_names.dart';
import 'package:ya_perfume/core/animation/app_animation.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/textstyles.dart';
import 'package:ya_perfume/core/theme/app_theme_colors.dart';
import 'package:ya_perfume/features/questions/presentation/cubit/questions_cubit.dart';
import 'package:ya_perfume/features/questions/presentation/widgets/questions_widgets/question_body_widgets/question_options.dart';

class QuestionContent extends StatelessWidget {
  final QuestionsCubit cubit;
  final AppThemeColors theme;
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
              cubit.currentQuestion.title.tr(),
              style: AppTextStyle.font15textAccentRegularNoto().copyWith(
                color: theme.title,
              ),
              textAlign: TextAlign.right,
            ),
            verticalSpace(16),
            Text(
              cubit.currentQuestion.questionText.tr(),
              style: AppTextStyle.font34textPrimarySemiBoldNoto().copyWith(
                color: theme.textPrimary,
              ),
              textAlign: TextAlign.right,
            ),
            verticalSpace(8),
            Text(
              cubit.currentQuestion.note.tr(),
              style: AppTextStyle.font17textMutedRegularNoto().copyWith(
                color: theme.textSecondary,
              ),
              textAlign: TextAlign.right,
            ),
            verticalSpace(8),
            Expanded(
              child: QuestionOptions(
                cubit: cubit,
                availableHeight: availableHeight,
              ),
            ),
            verticalSpace(12),
            if (cubit.currentQuestion.id == '5') ...[
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
                  'learn_family_differences'.tr(),
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
                      'maximum_two_families_message'.tr(),
                      style: AppTextStyle.font16textAccentMediumNoto().copyWith(
                        color: theme.title,
                      ),
                      textAlign: TextAlign.right,
                    )
                  : const SizedBox.shrink(),
              verticalSpace(12),
            ],
            SizedBox(height: (availableHeight * 0.14)),
          ],
        ),
      ),
    );
  }
}
