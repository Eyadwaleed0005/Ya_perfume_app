import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/core/helper/perfume_data_translator.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/style/textstyles.dart';

class PerfumeClosestFamilies extends StatelessWidget {
  final List<String> families;

  const PerfumeClosestFamilies({super.key, required this.families});

  @override
  Widget build(BuildContext context) {
    final languageCode = context.locale.languageCode;
    final isArabic = languageCode == 'ar';

    final translatedFamilies = PerfumeDataTranslator.translateList(
      families,
      languageCode: languageCode,
    );

    return Directionality(
      textDirection: isArabic ? ui.TextDirection.rtl : ui.TextDirection.ltr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'perfume_closest_families'.tr(),
            textAlign: TextAlign.start,
            style: AppTextStyle.font23textPrimarySemiBoldNoto(),
          ),
          verticalSpace(12),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              for (final family in translatedFamilies)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.r),
                    border: Border.all(
                      color: AppColors.borderAccent,
                      width: 1.w,
                    ),
                  ),
                  child: Text(
                    family,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.font16textAccentMediumNoto(),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
