import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/widgets/custom_button.dart';

class ResultActions extends StatelessWidget {
  final VoidCallback onStartAgain;
  final VoidCallback onReviewSelections;

  const ResultActions({
    super.key,
    required this.onStartAgain,
    required this.onReviewSelections,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: ui.TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomButton(
          text: 'results_start_again'.tr(),
          onPressed: onStartAgain,
          width: 230.w,
          height: 52.h,
          background: AppColors.bgCanvas,
          foreground: AppColors.textPrimary,
          borderColor: AppColors.borderSubtle,
          borderWidth: 0.5.w,
        ),
        CustomButton(
          text: 'results_review_selections'.tr(),
          onPressed: onReviewSelections,
          width: 280.w,
          height: 52.h,
          background: AppColors.bgAccent,
          foreground: AppColors.textUltraBlack,
        ),
      ],
    );
  }
}