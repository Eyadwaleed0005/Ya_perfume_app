import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/style/textstyles.dart';
import 'package:ya_perfume/core/theme/app_theme.dart';
import 'package:ya_perfume/core/theme/app_theme_colors.dart';
import 'package:ya_perfume/core/widgets/custom_button.dart';
import 'package:ya_perfume/core/widgets/circular_butter_fly.dart';
import 'package:ya_perfume/core/widgets/custom_background.dart';

class BeforeTheFamiliesScreenContent extends StatelessWidget {
  final AppThemeType? themeType;

  const BeforeTheFamiliesScreenContent({super.key, this.themeType});

  @override
  Widget build(BuildContext context) {
    AppThemeType effectiveThemeType = themeType ?? AppThemeType.normal;
    AppThemeColors theme = AppTheme.fromType(effectiveThemeType);
    final isArabic = context.locale.languageCode == 'ar';

    final size = MediaQuery.sizeOf(context);
    final sw = size.width;
    final sh = size.height;

    return Stack(
      children: [
        CustomBackground(
          backGroundColor: theme.background,
          primaryColor: theme.primary.withValues(alpha: 0.14),
          secondaryColor: theme.secondary,
        ),

        Positioned(
          top: sh * 0.03,
          left: sw * 0.05,
          child: Text(
            'app_name'.tr(),

            style: AppTextStyle.font18TextAccentMediumNoto().copyWith(
              color: theme.title,
            ),
          ),
        ),

        Center(
          child: Column(
            textDirection: isArabic
                ? ui.TextDirection.rtl
                : ui.TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularButterFly(
                height: sh * 0.20,
                width: sh * 0.20,
                background: theme.background,
              ),

              SizedBox(height: sh * 0.02),

              Text(
                'discover_your_preferred_scents'.tr(),
                textDirection: isArabic
                    ? ui.TextDirection.rtl
                    : ui.TextDirection.ltr,
                style: AppTextStyle.font36textPrimarySemiBoldNoto().copyWith(
                  color: theme.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: sh * 0.015),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.w),
                child: Text(
                  'choose_up_to_two_families'.tr(),
                  textDirection: isArabic
                      ? ui.TextDirection.rtl
                      : ui.TextDirection.ltr,
                  style: AppTextStyle.font21textPrimaryRegularNoto().copyWith(
                    color: theme.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: sh * 0.07),

              CustomButton(
                text: 'choose_preferred_scents'.tr(),
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
