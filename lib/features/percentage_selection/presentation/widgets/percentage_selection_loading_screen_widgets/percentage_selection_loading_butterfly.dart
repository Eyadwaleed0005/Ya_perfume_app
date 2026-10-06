import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ya_perfume/app/routes/app_images_routes.dart';
import 'package:ya_perfume/core/animation/app_animation.dart';
import 'package:ya_perfume/core/style/app_color.dart';

class PercentageSelectionLoadingButterfly extends StatelessWidget {
  const PercentageSelectionLoadingButterfly({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175.r,
      height: 175.r,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.bgCanvas,
        border: Border.all(color: AppColors.goldAccent, width: 1.5.r),
      ),
      child: AppAnimation.percentageSelectionButterflyFlight(
        flightRadius: 170.r,
        child: SvgPicture.asset(
          AppImage().goldButterfly,
          width: 120.r,
          height: 120.r,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
