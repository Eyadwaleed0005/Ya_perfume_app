import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/style/textstyles.dart';
import 'package:ya_perfume/core/theme/app_theme.dart';
import 'package:ya_perfume/core/widgets/custom_button.dart';
import 'package:ya_perfume/core/widgets/circular_butter_fly.dart';
import 'package:ya_perfume/core/widgets/custom_background.dart';

class BeforeTheFamiliesScreenContent extends StatelessWidget {
  final AppThemeType? themeType;

  const BeforeTheFamiliesScreenContent({super.key, this.themeType});

  @override
  Widget build(BuildContext context) {
    final effectiveThemeType = themeType ?? AppThemeType.normal;
    final theme = AppTheme.fromType(effectiveThemeType);
    final isArabic = context.locale.languageCode == 'ar';

    final textDirection = isArabic
        ? ui.TextDirection.rtl
        : ui.TextDirection.ltr;

    return Stack(
      fit: StackFit.expand,
      children: [
        CustomBackground(
          backGroundColor: theme.background,
          primaryColor: theme.primary.withValues(alpha: 0.14),
          secondaryColor: theme.secondary,
        ),
        SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final horizontalPadding = math.min(
                32.w,
                constraints.maxWidth * 0.06,
              );
              final verticalPadding = 16.h;

              final butterflySize = (constraints.maxHeight * 0.20).clamp(
                64.0,
                140.0,
              );

              final buttonWidth = math.min(
                280.w,
                constraints.maxWidth - horizontalPadding * 2,
              );

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: verticalPadding,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: math.max(
                        0.0,
                        constraints.maxHeight - verticalPadding * 2,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'app_name'.tr(),
                            style: AppTextStyle.font18TextAccentMediumNoto()
                                .copyWith(color: theme.title),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.h),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularButterFly(
                                height: butterflySize,
                                width: butterflySize,
                                background: theme.background,
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                'discover_your_preferred_scents'.tr(),
                                textDirection: textDirection,
                                textAlign: TextAlign.center,
                                style:
                                    AppTextStyle.font36textPrimarySemiBoldNoto()
                                        .copyWith(color: theme.textPrimary),
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                'choose_up_to_two_families'.tr(),
                                textDirection: textDirection,
                                textAlign: TextAlign.center,
                                style:
                                    AppTextStyle.font21textPrimaryRegularNoto()
                                        .copyWith(color: theme.textPrimary),
                              ),
                              SizedBox(height: 28.h),
                              CustomButton(
                                text: 'choose_preferred_scents'.tr(),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                width: buttonWidth,
                                height: math.max(44.0, 40.h),
                                background: theme.primaryButton,
                                foreground: AppColors.textUltraBlack,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
