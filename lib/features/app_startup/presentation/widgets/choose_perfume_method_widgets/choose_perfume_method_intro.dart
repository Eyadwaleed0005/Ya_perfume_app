import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ya_perfume/app/routes/app_images_routes.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/style/textstyles.dart';

class ChoosePerfumeMethodIntro extends StatelessWidget {
  const ChoosePerfumeMethodIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.rtl,
      children: [
        Container(
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
        Container(
          width: 360.w,
          height: 96.h,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColors.bgCanvas,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.goldAccentLight, width: 1.w),
          ),
          child: Text(
            'choose_perfume_method_intro'.tr(),
            textAlign: TextAlign.center,
            style: AppTextStyle.font17textPrimaryRegularNoto(),
          ),
        ),
      ],
    );
  }
}
