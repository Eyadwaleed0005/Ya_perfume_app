import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ya_perfume/app/routes/app_images_routes.dart';
import 'package:ya_perfume/core/style/app_color.dart';

class CircularButterFly extends StatelessWidget {
  final double height;
  final double width;
  const CircularButterFly({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.bgCanvas,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.goldAccent, width: 1.w),
      ),
      child: Padding(
        padding: EdgeInsets.all(width * 0.12),
        child: SvgPicture.asset(
          AppImage().butterflyImg,

          colorFilter: const ColorFilter.mode(
            AppColors.goldAccent,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
