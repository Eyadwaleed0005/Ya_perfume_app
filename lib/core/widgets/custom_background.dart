import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ya_perfume/core/style/app_color.dart';

class CustomBackground extends StatelessWidget {
  final Color backGroundColor;
  final Color primaryColor;
  final Color secondaryColor;

  const CustomBackground({
    super.key,
    this.backGroundColor = AppColors.normalBackground,
    this.primaryColor = AppColors.goldAccent,
    this.secondaryColor = AppColors.goldAccent,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: ClipRect(
          child: ColoredBox(
            color: backGroundColor,
            child: Center(
              child: FractionallySizedBox(
                widthFactor: 0.75,
                heightFactor: 0.85,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 35, sigmaY: 35),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        radius: 0.7,
                        colors: [
                          primaryColor.withValues(alpha: 0.20),
                          primaryColor.withValues(alpha: 0.08),
                          secondaryColor.withValues(alpha: 0),
                        ],
                        stops: const [0, 0.55, 1],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
