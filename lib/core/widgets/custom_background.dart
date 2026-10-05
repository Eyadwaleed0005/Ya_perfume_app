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
    return Transform.scale(
      scaleX: 1.2,
      scaleY: 1.0,
      child: Container(
        color: backGroundColor,
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(-0.0, -0.15),
              radius: 0.75,
              colors: [
                primaryColor.withValues(alpha: 0.14),
                secondaryColor.withValues(alpha: 0.07),
                //secondaryColor.withValues(alpha: 0.05),
                Colors.transparent,
              ],
              stops: const [0.0, 0.45, 1.0],
            ),
          ),
        ),
      ),
    );
  }
}
