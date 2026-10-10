import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ya_perfume/app/routes/route_names.dart';
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
    final question = cubit.currentQuestion;
    final note = question.note.tr();
    final isArabic = context.locale.languageCode == 'ar';

    final textAlign = isArabic ? TextAlign.right : TextAlign.left;

    return Expanded(
      flex: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: isArabic
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(
            question.title.tr(),
            style: AppTextStyle.font15textAccentRegularNoto().copyWith(
              color: theme.title,
            ),
            textAlign: textAlign,
          ),
          verticalSpace(8),
          Text(
            question.questionText.tr(),
            style: AppTextStyle.font34textPrimarySemiBoldNoto().copyWith(
              color: theme.textPrimary,
            ),
            textAlign: textAlign,
          ),
          if (note.trim().isNotEmpty) ...[
            verticalSpace(8),
            Text(
              note,
              style: AppTextStyle.font17textMutedRegularNoto().copyWith(
                color: theme.textSecondary,
              ),
              textAlign: textAlign,
            ),
          ],
          verticalSpace(16),

          QuestionOptions(cubit: cubit, availableHeight: availableHeight),

          if (question.id == '5') ...[
            verticalSpace(12),
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
                    .copyWith(color: theme.title, decorationColor: theme.title),
                textAlign: textAlign,
              ),
            ),
            if (cubit.state.showInfo) ...[
              verticalSpace(8),
              Text(
                'maximum_two_families_message'.tr(),
                style: AppTextStyle.font16textAccentMediumNoto().copyWith(
                  color: theme.title,
                ),
                textAlign: textAlign,
              ),
            ],
          ],
        ],
      ),
    );
  }
}
