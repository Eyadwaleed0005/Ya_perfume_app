import 'dart:math' as math;
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
import 'package:ya_perfume/features/questions/data/models/fragrance_family_model.dart';
import 'package:ya_perfume/features/questions/presentation/widgets/discover_fragrance_families_widget/family_card.dart';

class DiscoverFragranceFamiliesScreenContent extends StatelessWidget {
  final List<FragranceFamily> families;
  final AppThemeType? themeType;

  const DiscoverFragranceFamiliesScreenContent({
    super.key,
    required this.families,
    this.themeType,
  });

  double _calculateCardHeight({
    required BuildContext context,
    required double cardWidth,
    required AppThemeColors theme,
    required ui.TextDirection textDirection,
  }) {
    final padding = 14.r;
    const borderWidth = 1.0;

    final textWidth = math.max(1.0, cardWidth - padding * 2 - borderWidth * 2);

    final numberStyle = AppTextStyle.font16textAccentMediumNoto().copyWith(
      color: theme.title,
    );

    final titleStyle = AppTextStyle.font18textPrimarySemiBoldNoto().copyWith(
      color: theme.textPrimary,
      height: 1.4,
    );

    final descriptionStyle = AppTextStyle.font16textMutedRegularNoto().copyWith(
      color: theme.textSecondary,
      height: 1.5,
    );

    double measureText(String text, TextStyle style) {
      final painter = TextPainter(
        text: TextSpan(
          text: text,
          style: DefaultTextStyle.of(context).style.merge(style),
        ),
        textDirection: textDirection,
        textScaler: MediaQuery.textScalerOf(context),
        locale: Localizations.localeOf(context),
      );

      painter.layout(maxWidth: textWidth);

      final height = painter.height;
      painter.dispose();

      return height;
    }

    double maxHeight = 0;

    for (final family in families) {
      final height =
          padding * 2 +
          borderWidth * 2 +
          measureText(family.number, numberStyle) +
          8.h +
          measureText(family.title.tr(), titleStyle) +
          12.h +
          measureText(family.description.tr(), descriptionStyle);

      maxHeight = math.max(maxHeight, height);
    }

    return math.max(1.0, maxHeight.ceilToDouble() + 2);
  }

  @override
  Widget build(BuildContext context) {
    final effectiveThemeType = themeType ?? AppThemeType.normal;
    final theme = AppTheme.fromType(effectiveThemeType);
    final isArabic = context.locale.languageCode == 'ar';

    final textDirection = isArabic
        ? ui.TextDirection.rtl
        : ui.TextDirection.ltr;

    final textAlign = isArabic ? TextAlign.right : TextAlign.left;

    return Stack(
      fit: StackFit.expand,
      children: [
        CustomBackground(
          backGroundColor: theme.background,
          primaryColor: theme.primary.withValues(alpha: 0.14),
          secondaryColor: theme.secondary,
        ),
        SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'app_name'.tr(),
                      style: AppTextStyle.font18TextAccentMediumNoto().copyWith(
                        color: theme.textSecondary,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularButterFly(
                        width: 64.r,
                        height: 64.r,
                        background: theme.background,
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: isArabic
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              'discover_fragrance_families'.tr(),
                              textDirection: textDirection,
                              textAlign: textAlign,
                              style:
                                  AppTextStyle.font34textPrimarySemiBoldNoto()
                                      .copyWith(color: theme.textPrimary),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'fragrance_families_description'.tr(),
                              textDirection: textDirection,
                              textAlign: textAlign,
                              style: AppTextStyle.font18textMutedRegularNoto()
                                  .copyWith(color: theme.textSecondary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final availableWidth = constraints.maxWidth;
                      final spacing = 16.w;

                      final int columns;

                      if (availableWidth >= 900) {
                        columns = 4;
                      } else if (availableWidth >= 650) {
                        columns = 3;
                      } else if (availableWidth >= 420) {
                        columns = 2;
                      } else {
                        columns = 1;
                      }

                      final cardWidth =
                          (availableWidth - spacing * (columns - 1)) / columns;

                      final cardHeight = _calculateCardHeight(
                        context: context,
                        cardWidth: cardWidth,
                        theme: theme,
                        textDirection: textDirection,
                      );

                      return Directionality(
                        textDirection: textDirection,
                        child: GridView.builder(
                          // الـ Grid بياخد ارتفاع الكروت كلها.
                          shrinkWrap: true,
                          primary: false,

                          // الـ Scroll للشاشة الخارجية فقط.
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: families.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: columns,
                                crossAxisSpacing: spacing,
                                mainAxisSpacing: 16.h,
                                mainAxisExtent: cardHeight,
                              ),
                          itemBuilder: (context, index) {
                            return FamilyCard(
                              family: families[index],
                              themeType: effectiveThemeType,
                            );
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 24.h),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Align(
                        alignment: isArabic
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: CustomButton(
                          text: 'back_to_choices'.tr(),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          width: math.min(260.w, constraints.maxWidth),
                          height: math.max(44.0, 40.h),
                          background: theme.primaryButton,
                          foreground: AppColors.textUltraBlack,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
