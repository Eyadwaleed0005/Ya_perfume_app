import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/style/textstyles.dart';

class PerfumeProductCode extends StatelessWidget {
  final int? code;

  const PerfumeProductCode({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    final formattedCode = code == null || code == 0 ? '0000' : code.toString();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderAccent, width: 1.w),
      ),
      child: Row(
        textDirection: ui.TextDirection.ltr,
        children: [
          Text(
            'YA-$formattedCode',
            textDirection: ui.TextDirection.ltr,
            style: AppTextStyle.font24textAccentSemiBoldNoto(),
          ),
          horizontalSpace(16),
          Expanded(
            child: Text(
              'perfume_product_code'.tr(),
              textAlign: TextAlign.right,
              style: AppTextStyle.font17textSecondaryRegularNoto(),
            ),
          ),
        ],
      ),
    );
  }
}
