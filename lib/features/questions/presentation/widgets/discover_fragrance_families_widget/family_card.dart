import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/theme/app_theme.dart';
import 'package:ya_perfume/core/style/textstyles.dart';
import 'package:ya_perfume/core/theme/app_theme_colors.dart';
import 'package:ya_perfume/features/questions/data/models/fragrance_family_model.dart';

class FamilyCard extends StatelessWidget {
  final FragranceFamily family;
  final AppThemeType? themeType;

  const FamilyCard({super.key, required this.family, this.themeType});

  @override
  Widget build(BuildContext context) {
    AppThemeType effectiveThemeType = themeType ?? AppThemeType.normal;
    AppThemeColors theme = AppTheme.fromType(effectiveThemeType);

    return Container(
      padding: EdgeInsets.all(14.w),
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
            textDirection: TextDirection.rtl,
          ),
          verticalSpace(8),
          Text(
            family.title,
            style: AppTextStyle.font18textPrimarySemiBoldNoto().copyWith(
              color: theme.textPrimary,
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
          ),
          verticalSpace(12),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              family.description,
              style: AppTextStyle.font16textMutedRegularNoto().copyWith(
                color: theme.textSecondary,
              ),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
