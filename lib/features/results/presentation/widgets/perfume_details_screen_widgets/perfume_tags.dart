import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/core/helper/perfume_data_translator.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/style/textstyles.dart';

class PerfumeTags extends StatelessWidget {
  final List<String> tags;

  const PerfumeTags({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    final languageCode = context.locale.languageCode;
    final isArabic = languageCode == 'ar';

    final translatedTags = PerfumeDataTranslator.translateList(
      tags,
      languageCode: languageCode,
    );

    return Directionality(
      textDirection: isArabic ? ui.TextDirection.rtl : ui.TextDirection.ltr,
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            for (final tag in translatedTags)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.bgSurfaceRaised,
                  borderRadius: BorderRadius.circular(100.r),
                  border: Border.all(
                    color: AppColors.borderSubtle,
                    width: 0.5.w,
                  ),
                ),
                child: Text(
                  tag,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.font14TextPrimaryMediumNoto(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
