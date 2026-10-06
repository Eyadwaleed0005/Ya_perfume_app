import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ya_perfume/app/routes/app_images_routes.dart';
import 'package:ya_perfume/core/animation/app_animation.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/style/textstyles.dart';

class ChoosePerfumeMethodIntro extends StatelessWidget {
  const ChoosePerfumeMethodIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppAnimation.appStartupEntrance(
          delay: const Duration(milliseconds: 40),
          child: Container(
            width: 112.w,
            height: 112.h,
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.goldAccent, width: 1.5.w),
            ),
            child: Center(
              child: SvgPicture.asset(
                AppImage().goldButterfly,
                width: 88.w,
                height: 88.h,
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
        AppAnimation.appStartupEntrance(
          delay: const Duration(milliseconds: 80),
          child: Container(
            width: 360.w,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            decoration: BoxDecoration(
              color: AppColors.bgCanvas,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.goldAccentLight, width: 1.w),
            ),
            child: Text(
              'choose_perfume_method_intro'.tr(context: context),
              textAlign: TextAlign.center,
              style: AppTextStyle.font17textPrimaryRegularNoto(),
            ),
          ),
        ),
      ],
    );
  }
}
