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
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.borderSubtle, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: PercentageSelectionBottle(
                percentage: percentage,
                liquidColor: liquidColor,
                width: 112.w,
              ),
            ),
          ),
          verticalSpace(8),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.font18textPrimaryMediumNoto(),
          ),
          verticalSpace(8),
          Row(
            textDirection: ui.TextDirection.ltr,
            children: [
              _buildControl(icon: Icons.remove, onPressed: onDecrease),
              Expanded(
                child: Text(
                  '${percentage.toStringAsFixed(0)}%',
                  textAlign: TextAlign.center,
                  textDirection: ui.TextDirection.ltr,
                  style: AppTextStyle.font25textAccentSemiBoldNoto(),
                ),
              ),
              _buildControl(icon: Icons.add, onPressed: onIncrease),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildControl({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return SizedBox.square(
      dimension: 40.r,
      child: IconButton.outlined(
        onPressed: onPressed,
        icon: Icon(icon),
        iconSize: 18.sp,
        style: IconButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          disabledForegroundColor: AppColors.textMuted.withValues(alpha: 0.35),
          side: const BorderSide(color: AppColors.borderSubtle),
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: const CircleBorder(),
        ),
      ),
    );
  }
}
