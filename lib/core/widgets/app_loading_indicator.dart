import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m3e_progress_indicator/m3e_progress_indicator.dart';
import 'package:ya_perfume/core/style/app_color.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({
    super.key,
    this.color = AppColors.goldAccent,
    this.backgroundColor = Colors.transparent,
    this.size = 24,
    this.strokeWidth = 2.5,
    this.wavelength = 12,
    this.waveSpeed = 10,
  });

  final Color color;
  final Color backgroundColor;
  final double size;
  final double strokeWidth;
  final double wavelength;
  final double waveSpeed;

  @override
  Widget build(BuildContext context) {
    return M3ECircularWavyProgressIndicator(
      value: null,
      color: color,
      backgroundColor: backgroundColor,
      size: size.r,
      strokeWidth: strokeWidth.r,
      trackStrokeWidth: strokeWidth.r,
      wavelength: wavelength.r,
      waveSpeed: waveSpeed,
    );
  }
}