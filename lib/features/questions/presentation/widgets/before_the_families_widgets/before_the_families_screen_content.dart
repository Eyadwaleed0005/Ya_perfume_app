import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

    // Read screen dimensions once at the top of build() — RULE 2
    final size = MediaQuery.sizeOf(context);
    final sw = size.width;
    final sh = size.height;

    return Stack(
      children: [
        QuestionBackground(
          backGroundColor: theme.background,
          primaryColor: theme.primary.withValues(alpha: 0.14),
          secondaryColor: theme.secondary,
        ),

        // RULE 5: Positioned uses proportional values from screen dimensions
        Positioned(
          top: sh * 0.03,
          left: sw * 0.05,
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
              // Proportional butterfly circle — avoids hardcoded 170.h/170.w
              CircularButterFly(
                height: sh * 0.20,
                width: sh * 0.20,
                background: theme.background,
              ),

              // Proportional spacing instead of hardcoded verticalSpace(14)
              SizedBox(height: sh * 0.02),

              Text(
                'لنكتشف الروائح التي تفضّلها',
                style: AppTextStyle.font36textPrimarySemiBoldNoto().copyWith(
                  color: theme.textPrimary,
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),

              SizedBox(height: sh * 0.015),

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

              // Proportional spacing instead of hardcoded verticalSpace(60)
              SizedBox(height: sh * 0.07),

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
