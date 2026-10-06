import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/core/style/app_color.dart';

class PercentageSelectionBottle extends StatelessWidget {
  final double percentage;
  final Color liquidColor;

  const PercentageSelectionBottle({
    super.key,
    required this.percentage,
    required this.liquidColor,
  });

  @override
  Widget build(BuildContext context) {
    final fill = (percentage / 100).clamp(0.0, 1.0).toDouble();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 58.w,
          height: 26.h,
          decoration: BoxDecoration(
            color: AppColors.mutedGray.withValues(alpha: 0.75),
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        SizedBox(height: 2.h),
        Container(
          width: 112.w,
          height: 160.h,
          padding: EdgeInsets.all(5.r),
          decoration: BoxDecoration(
            color: AppColors.bgSurfaceRaised,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: AppColors.mutedGray.withValues(alpha: 0.4),
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(9.r),
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: fill),
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    heightFactor: value,
                    child: child,
                  ),
                );
              },
              child: ColoredBox(color: liquidColor),
            ),
          ),
        ),
      ],
    );
  }
}
