import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ya_perfume/app/routes/app_images_routes.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/style/textstyles.dart';

class ResultPerfumeCard extends StatelessWidget {
  final VoidCallback onTap;

  const ResultPerfumeCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(24.r);
    final isArabic = context.locale.languageCode == 'ar';

    final detailsText = Text(
      'perfume_details'.tr(),
      textDirection: isArabic ? ui.TextDirection.rtl : ui.TextDirection.ltr,
      textAlign: TextAlign.center,
      maxLines: 1,
      softWrap: false,
      style: AppTextStyle.font18TextAccentMediumNoto(),
    );

    final arrow = Icon(
      Icons.arrow_back,
      textDirection: ui.TextDirection.ltr,
      size: 16.sp,
      color: AppColors.textAccent,
    );

    return AspectRatio(
      aspectRatio: 167 / 210,
      child: Material(
        color: AppColors.bgSurface,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
          side: const BorderSide(color: AppColors.borderAccent, width: 1),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Center(
                    child: FractionallySizedBox(
                      widthFactor: 0.65,
                      child: SvgPicture.asset(
                        AppImage().perfumeBottle,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        textDirection: isArabic
                            ? ui.TextDirection.rtl
                            : ui.TextDirection.ltr,
                        children: isArabic
                            ? [detailsText, horizontalSpace(6), arrow]
                            : [arrow, horizontalSpace(6), detailsText],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
