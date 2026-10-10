import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ya_perfume/core/theme/app_theme.dart';
import 'package:ya_perfume/core/style/textstyles.dart';
import 'package:ya_perfume/features/questions/data/models/fragrance_family_model.dart';

class FamilyCard extends StatelessWidget {
  final FragranceFamily family;
  final AppThemeType? themeType;

  const FamilyCard({super.key, required this.family, this.themeType});

  @override
  Widget build(BuildContext context) {
    final effectiveThemeType = themeType ?? AppThemeType.normal;
    final theme = AppTheme.fromType(effectiveThemeType);
    final isArabic = context.locale.languageCode == 'ar';

    return Directionality(
      textDirection: isArabic ? ui.TextDirection.rtl : ui.TextDirection.ltr,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          color: theme.surfaceOff,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            width: 1,
            color: theme.borderOff.withValues(alpha: 0.14),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              family.number,
              style: AppTextStyle.font16textAccentMediumNoto().copyWith(
                color: theme.title,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              family.title.tr(),
              textAlign: TextAlign.start,
              style: AppTextStyle.font18textPrimarySemiBoldNoto().copyWith(
                color: theme.textPrimary,
                height: 1.4,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              family.description.tr(),
              textAlign: TextAlign.start,
              softWrap: true,
              style: AppTextStyle.font16textMutedRegularNoto().copyWith(
                color: theme.textSecondary,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
