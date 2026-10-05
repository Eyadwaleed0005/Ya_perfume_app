import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/core/style/app_color.dart';

import 'splash_progress_marker.dart';

class SplashLoadingBar extends StatelessWidget {
  const SplashLoadingBar({super.key, required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final value = progress.clamp(0.0, 1.0).toDouble();

    final markerSize = 40.w;
    final barHeight = 22.w;
    final borderWidth = 2.w;
    final inset = 5.w;
    final flightDepth = 65.w;
    final flightProgress = ((value - 0.20) / 0.70).clamp(0.0, 1.0).toDouble();
    final isFlying = value > 0.20 && value < 0.90;
    final flightOffset = isFlying
        ? math.sin(math.pi * flightProgress) * flightDepth
        : 0.0;

    return SizedBox(
      width: 300.w,
      height: markerSize + flightDepth,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final markerCenter = inset + (width - inset * 2) * value;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: (markerSize - barHeight) / 2,
                height: barHeight,
                child: CustomPaint(
                  painter: _LoadingBarPainter(
                    progress: value,
                    borderWidth: borderWidth,
                    inset: inset,
                  ),
                ),
              ),
              Positioned(
                left: markerCenter - markerSize / 2,
                top: flightOffset,
                child: SplashProgressMarker(
                  size: markerSize,
                  isLoading: value < 1,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _LoadingBarPainter extends CustomPainter {
  const _LoadingBarPainter({
    required this.progress,
    required this.borderWidth,
    required this.inset,
  });

  final double progress;
  final double borderWidth;
  final double inset;

  Path _barPath(Rect rect) {
    final tipWidth = rect.height * 0.32;

    return Path()
      ..moveTo(rect.left + tipWidth, rect.top)
      ..lineTo(rect.right - tipWidth, rect.top)
      ..lineTo(rect.right, rect.center.dy)
      ..lineTo(rect.right - tipWidth, rect.bottom)
      ..lineTo(rect.left + tipWidth, rect.bottom)
      ..lineTo(rect.left, rect.center.dy)
      ..close();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final bounds = Offset.zero & size;
    final outerPath = _barPath(bounds.deflate(borderWidth / 2));

    canvas.drawPath(
      outerPath,
      Paint()
        ..color = AppColors.bgCanvas
        ..style = PaintingStyle.fill,
    );

    final innerRect = bounds.deflate(inset);

    if (!innerRect.isEmpty && progress > 0) {
      canvas.save();
      canvas.clipPath(_barPath(innerRect));

      canvas.drawRect(
        Rect.fromLTWH(
          innerRect.left,
          innerRect.top,
          innerRect.width * progress,
          innerRect.height,
        ),
        Paint()..color = AppColors.goldAccent,
      );

      canvas.restore();
    }

    canvas.drawPath(
      outerPath,
      Paint()
        ..color = AppColors.goldAccent
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth
        ..strokeJoin = StrokeJoin.miter,
    );
  }

  @override
  bool shouldRepaint(covariant _LoadingBarPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.inset != inset;
  }
}
