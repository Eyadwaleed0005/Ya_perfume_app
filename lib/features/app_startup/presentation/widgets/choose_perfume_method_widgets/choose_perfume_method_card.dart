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

    return SizedBox(
      width: 420.w,
      height: 380.h,
      child: Material(
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
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14.r),
                  child: SizedBox(
                    width: double.infinity,
                    height: 200.h,
                    child: SvgPicture.asset(
                      imagePath,
                      fit: BoxFit.fill,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                verticalSpace(16),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        title,
                        textDirection: textDirection,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.font18textPrimarySemiBoldNoto(),
                      ),
                      verticalSpace(10),
                      Flexible(
                        child: Text(
                          description,
                          textDirection: textDirection,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.font15textMutedRegularNoto(),
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpace(12),
                Row(
                  mainAxisSize: MainAxisSize.min,
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
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.font15textMutedRegularNoto(),
                      ),
                    ),
                  ],
                ),
                verticalSpace(10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
