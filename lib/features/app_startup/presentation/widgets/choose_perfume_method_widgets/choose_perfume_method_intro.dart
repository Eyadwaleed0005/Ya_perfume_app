import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ya_perfume/app/routes/app_images_routes.dart';
import 'package:ya_perfume/core/animation/app_animation.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/style/textstyles.dart';

class ChoosePerfumeMethodIntro extends StatelessWidget {
  const ChoosePerfumeMethodIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 478.w),
        child: Row(
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppAnimation.appStartupEntrance(
              delay: const Duration(milliseconds: 40),
              child: Container(
                width: 112.w,
                height: 112.w,
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.goldAccent, width: 1.5.w),
                ),
                child: SvgPicture.asset(
                  AppImage().goldButterfly,
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                ),
              ),
            ),
            horizontalSpace(6),
            Expanded(
              child: AppAnimation.appStartupEntrance(
                delay: const Duration(milliseconds: 80),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 24.w,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.bgCanvas,
                    borderRadius: BorderRadius.circular(16.w),
                    border: Border.all(
                      color: AppColors.goldAccentLight,
                      width: 1.w,
                    ),
                  ),
                  child: Text(
                    'choose_perfume_method_intro'.tr(context: context),
                    textDirection: context.locale.languageCode == 'ar'
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.font17textPrimaryRegularNoto(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
