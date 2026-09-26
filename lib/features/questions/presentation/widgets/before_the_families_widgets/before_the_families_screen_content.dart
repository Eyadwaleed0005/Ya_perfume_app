import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/style/textstyles.dart';
import 'package:ya_perfume/core/theme/app_theme.dart';
import 'package:ya_perfume/core/theme/app_theme_colors.dart';
import 'package:ya_perfume/core/widgets/custom_button.dart';
import 'package:ya_perfume/features/questions/presentation/widgets/before_the_families_widgets/circular_butter_fly.dart';
import 'package:ya_perfume/features/questions/presentation/widgets/questions_widgets/question_background.dart';

class BeforeTheFamiliesScreenContent extends StatelessWidget {
  final AppThemeType? themeType;

  const BeforeTheFamiliesScreenContent({super.key, this.themeType});

  @override
  Widget build(BuildContext context) {
    AppThemeType effectiveThemeType = themeType ?? AppThemeType.normal;
    AppThemeColors theme = AppTheme.fromType(effectiveThemeType);

    return Stack(
      children: [
        QuestionBackground(
          backGroundColor: theme.background,
          primaryColor: theme.primary.withValues(alpha: 0.14),
          secondaryColor: theme.secondary,
        ),

        Positioned(
          top: 24.h,
          left: 64.w,
          child: Text(
            'YA  PERFUME',
            style: AppTextStyle.font18TextAccentMediumNoto().copyWith(
              color: theme.title,
            ),
          ),
        ),

        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularButterFly(
                height: 170.h,
                width: 170.w,
                background: theme.background,
              ),
              Text(
                'لنكتشف الروائح التي تفضّلها',
                style: AppTextStyle.font36textPrimarySemiBoldNoto().copyWith(
                  color: theme.textPrimary,
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),

              verticalSpace(14),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.w),
                child: Text(
                  'اختر عائلة عطرية واحدة أو عائلتين، وسأساعدك على فهم الفروق بينهما.',
                  style: AppTextStyle.font21textPrimaryRegularNoto().copyWith(
                    color: theme.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),
              ),

              verticalSpace(60),

              CustomButton(
                text: 'اختيار الروائح المفضّلة',
                onPressed: () {
                  Navigator.of(context).pop();
                },
                width: 280.w,
                height: 40.h,
                background: theme.primaryButton,
                foreground: AppColors.textUltraBlack,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
