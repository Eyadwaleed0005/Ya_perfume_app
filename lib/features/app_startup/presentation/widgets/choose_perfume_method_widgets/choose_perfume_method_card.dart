import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/style/textstyles.dart';

class ChoosePerfumeMethodCard extends StatelessWidget {
  const ChoosePerfumeMethodCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.footer,
    required this.onTap,
  });

  final String imagePath;
  final String title;
  final String description;
  final String footer;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(22.r);
    final textDirection = context.locale.languageCode == 'ar'
        ? TextDirection.rtl
        : TextDirection.ltr;

    return Material(
      color: AppColors.bgCanvas,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: BorderSide(color: AppColors.goldAccent, width: 1.5.w),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        splashColor: AppColors.goldAccent.withValues(alpha: 0.15),
        highlightColor: AppColors.goldAccent.withValues(alpha: 0.08),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14.r),
                child: AspectRatio(
                  aspectRatio: 460 / 220,
                  child: SvgPicture.asset(
                    imagePath,
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              verticalSpace(12),
              Text(
                title,
                textDirection: textDirection,
                textAlign: TextAlign.center,
                style: AppTextStyle.font18textPrimarySemiBoldNoto(),
              ),
              verticalSpace(8),
              Text(
                description,
                textDirection: textDirection,
                textAlign: TextAlign.center,
                style: AppTextStyle.font15textMutedRegularNoto(),
              ),
              verticalSpace(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                textDirection: TextDirection.ltr,
                children: [
                  Container(
                    width: 10.w,
                    height: 10.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.goldAccentLight,
                      border: Border.all(
                        color: AppColors.goldAccent,
                        width: 1.5.w,
                      ),
                    ),
                  ),
                  horizontalSpace(8),
                  Flexible(
                    child: Text(
                      footer,
                      textDirection: textDirection,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.font15textMutedRegularNoto(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
