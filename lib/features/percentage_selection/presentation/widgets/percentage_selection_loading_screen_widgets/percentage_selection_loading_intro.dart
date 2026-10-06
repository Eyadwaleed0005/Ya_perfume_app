import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ya_perfume/app/routes/app_images_routes.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/textstyles.dart';

class PercentageSelectionLoadingIntro extends StatelessWidget {
  const PercentageSelectionLoadingIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'percentage_selection_loading_title'.tr(),
          textAlign: TextAlign.center,
          style: AppTextStyle.font23textPrimarySemiBoldNoto(),
        ),
        verticalSpace(12),
        Text(
          'percentage_selection_loading_description'.tr(),
          textAlign: TextAlign.center,
          style: AppTextStyle.font21textPrimaryRegularNoto(),
        ),
        Transform.translate(
          offset: Offset(0, -50.h),
          child: SvgPicture.asset(
            AppImage().mothWingTrail,
            width: 320.w,
            fit: BoxFit.contain,
            alignment: Alignment.topCenter,
          ),
        ),
      ],
    );
  }
}