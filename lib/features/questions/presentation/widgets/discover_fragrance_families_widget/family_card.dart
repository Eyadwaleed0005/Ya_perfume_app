import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/theme/app_theme.dart';
import 'package:ya_perfume/core/style/textstyles.dart';
import 'package:ya_perfume/core/theme/app_theme_colors.dart';
import 'package:ya_perfume/features/questions/data/models/fragrance_family_model.dart';

import 'dart:ui' as ui;

class FamilyCard extends StatelessWidget {
  final FragranceFamily family;
  final AppThemeType? themeType;

  const FamilyCard({super.key, required this.family, this.themeType});

  @override
  Widget build(BuildContext context) {
    AppThemeType effectiveThemeType = themeType ?? AppThemeType.normal;
    AppThemeColors theme = AppTheme.fromType(effectiveThemeType);
    final isArabic = context.locale.languageCode == 'ar';

    return Directionality(
      textDirection: isArabic ? ui.TextDirection.rtl : ui.TextDirection.ltr,
      child: Container(
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          color: theme.surfaceOff,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: theme.borderOff.withValues(alpha: 0.14)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              family.number,
              style: AppTextStyle.font16textAccentMediumNoto().copyWith(
                color: theme.title,
              ),
            ),
            verticalSpace(8),
            Expanded(
              flex: 1,
              child: Text(
                family.title.tr(),
                style: AppTextStyle.font18textPrimarySemiBoldNoto().copyWith(
                  color: theme.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            verticalSpace(12),

            Expanded(
              flex: 4,
              child: Text(
                family.description.tr(),
                style: AppTextStyle.font16textMutedRegularNoto().copyWith(
                  color: theme.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
