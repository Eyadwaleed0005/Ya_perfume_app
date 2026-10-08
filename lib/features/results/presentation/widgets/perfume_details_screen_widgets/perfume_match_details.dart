import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/core/helper/perfume_data_translator.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/style/textstyles.dart';
import 'package:ya_perfume/features/results/domain/entities/perfume_result_entity.dart';

class PerfumeMatchDetails extends StatelessWidget {
  final PerfumeResultEntity perfume;

  const PerfumeMatchDetails({super.key, required this.perfume});

  @override
  Widget build(BuildContext context) {
    final languageCode = context.locale.languageCode;
    final isArabic = languageCode == 'ar';

    final usageTime = PerfumeDataTranslator.translate(
      perfume.usageTime,
      languageCode: languageCode,
    );

    final season = PerfumeDataTranslator.translate(
      perfume.season,
      languageCode: languageCode,
    );

    final families = PerfumeDataTranslator.translateList(
      perfume.preferredScents,
      languageCode: languageCode,
    ).join(' · ');

    final occasions = PerfumeDataTranslator.translateList(
      perfume.occasions,
      languageCode: languageCode,
    ).join(' · ');

    final projection = PerfumeDataTranslator.translate(
      perfume.projection,
      languageCode: languageCode,
    );

    return Directionality(
      textDirection: isArabic ? ui.TextDirection.rtl : ui.TextDirection.ltr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'perfume_matches_selections'.tr(),
            textAlign: TextAlign.start,
            style: AppTextStyle.font23textPrimarySemiBoldNoto(),
          ),
          verticalSpace(20),
          _PerfumeDetailRow(label: 'perfume_usage_time'.tr(), value: usageTime),
          verticalSpace(16),
          _PerfumeDetailRow(label: 'perfume_season'.tr(), value: season),
          verticalSpace(16),
          _PerfumeDetailRow(
            label: 'perfume_fragrance_family'.tr(),
            value: families,
          ),
          verticalSpace(16),
          _PerfumeDetailRow(label: 'perfume_occasion'.tr(), value: occasions),
          verticalSpace(16),
          _PerfumeDetailRow(
            label: 'perfume_projection'.tr(),
            value: projection,
          ),
        ],
      ),
    );
  }
}

class _PerfumeDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _PerfumeDetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Container(
                  width: 4.r,
                  height: 4.r,
                  decoration: const BoxDecoration(
                    color: AppColors.goldAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              horizontalSpace(10),
              Expanded(
                child: Text(
                  label,
                  textAlign: TextAlign.start,
                  style: AppTextStyle.font17textMutedRegularNoto(),
                ),
              ),
            ],
          ),
        ),
        horizontalSpace(20),
        Expanded(
          flex: 6,
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: AppTextStyle.font18textPrimarySemiBoldNoto(),
          ),
        ),
      ],
    );
  }
}
