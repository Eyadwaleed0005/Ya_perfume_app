import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStartupAnimationWidget extends StatelessWidget {
  const AppStartupAnimationWidget.entrance({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  final Widget child;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(child: child)
        .animate(delay: delay)
        .fadeIn(duration: 250.ms, curve: Curves.easeOut)
        .moveY(
          begin: 12.h,
          end: 0,
          duration: 250.ms,
          curve: Curves.easeOutCubic,
        );
  }
}
