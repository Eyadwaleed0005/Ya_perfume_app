import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/app_color.dart';

class PercentageSelectionBottle extends StatelessWidget {
  final double percentage;
  final Color liquidColor;
  final double? width;

  const PercentageSelectionBottle({
    super.key,
    required this.percentage,
    required this.liquidColor,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final fill = (percentage / 100).clamp(0.0, 1.0).toDouble();
    final bottleWidth = width ?? 112.w;
    final scale = bottleWidth / 112;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 58 * scale,
          height: 26 * scale,
          decoration: BoxDecoration(
            color: AppColors.mutedGray.withValues(alpha: 0.75),
            borderRadius: BorderRadius.circular(4 * scale),
          ),
        ),
        verticalSpace(2 * scale / 1.h),
        Container(
          width: bottleWidth,
          height: 160 * scale,
          padding: EdgeInsets.all(5 * scale),
          decoration: BoxDecoration(
            color: AppColors.bgSurfaceRaised,
            borderRadius: BorderRadius.circular(14 * scale),
            border: Border.all(
              color: AppColors.mutedGray.withValues(alpha: 0.4),
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(9 * scale),
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
