import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/widgets/custom_button.dart';

class PerfumeDetailsActions extends StatelessWidget {
  final VoidCallback onAllPerfumes;
  final VoidCallback onStartNewJourney;

  const PerfumeDetailsActions({
    super.key,
    required this.onAllPerfumes,
    required this.onStartNewJourney,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: ui.TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomButton(
          text: 'perfume_details_all_perfumes'.tr(),
          onPressed: onAllPerfumes,
          width: 230.w,
          height: 52.h,
          background: AppColors.bgCanvas,
          foreground: AppColors.textPrimary,
          borderColor: AppColors.borderSubtle,
          borderWidth: 0.5.w,
        ),
        CustomButton(
          text: 'perfume_details_start_new_journey'.tr(),
          onPressed: onStartNewJourney,
          width: 280.w,
          height: 52.h,
          background: AppColors.bgAccent,
          foreground: AppColors.textUltraBlack,
        ),
      ],
    );
  }
}