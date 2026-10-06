import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/style/textstyles.dart';

import 'percentage_selection_bottle.dart';

class PercentageSelectionCard extends StatelessWidget {
  final String title;
  final double percentage;
  final Color liquidColor;
  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;

  const PercentageSelectionCard({
    super.key,
    required this.title,
    required this.percentage,
    required this.liquidColor,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.borderSubtle, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PercentageSelectionBottle(
            percentage: percentage,
            liquidColor: liquidColor,
          ),
          verticalSpace(32),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyle.font18textPrimaryMediumNoto(),
          ),
          verticalSpace(16),
          Row(
            textDirection: ui.TextDirection.ltr,
            children: [
              IconButton.outlined(
                onPressed: onDecrease,
                icon: const Icon(Icons.remove),
                iconSize: 18.sp,
                style: IconButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                  disabledForegroundColor: AppColors.textMuted.withValues(
                    alpha: 0.35,
                  ),
                  side: const BorderSide(color: AppColors.borderSubtle),
                  fixedSize: Size.square(48.r),
                  padding: EdgeInsets.zero,
                  shape: const CircleBorder(),
                ),
              ),
              Expanded(
                child: Text(
                  '${percentage.toStringAsFixed(0)}%',
                  textAlign: TextAlign.center,
                  textDirection: ui.TextDirection.ltr,
                  style: AppTextStyle.font25textAccentSemiBoldNoto(),
                ),
              ),
              IconButton.outlined(
                onPressed: onIncrease,
                icon: const Icon(Icons.add),
                iconSize: 18.sp,
                style: IconButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                  disabledForegroundColor: AppColors.textMuted.withValues(
                    alpha: 0.35,
                  ),
                  side: const BorderSide(color: AppColors.borderSubtle),
                  fixedSize: Size.square(48.r),
                  padding: EdgeInsets.zero,
                  shape: const CircleBorder(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
