import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ya_perfume/core/style/app_color.dart';

class PercentageSelectionBackground extends StatelessWidget {
  const PercentageSelectionBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: ClipRect(
          child: ColoredBox(
            color: AppColors.bgCanvas,
            child: Center(
              child: FractionallySizedBox(
                widthFactor: 0.75,
                heightFactor: 0.85,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: 35,
                    sigmaY: 35,
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        radius: 0.7,
                        colors: [
                          AppColors.darkAutumnBrown.withValues(alpha: 0.20),
                          AppColors.darkAutumnBrown.withValues(alpha: 0.08),
                          AppColors.darkAutumnBrown.withValues(alpha: 0),
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