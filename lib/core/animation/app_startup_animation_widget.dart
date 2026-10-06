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

  Duration _remainingRouteTransition(BuildContext context) {
    final route = ModalRoute.of(context);

    if (route is! PageRoute) {
      return Duration.zero;
    }

    final animation = route.animation;

    if (animation == null || animation.status == AnimationStatus.completed) {
      return Duration.zero;
    }

    final remaining = (1 - animation.value).clamp(0.0, 1.0);

    return Duration(
      microseconds: (route.transitionDuration.inMicroseconds * remaining)
          .round(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final entranceDelay = _remainingRouteTransition(context) + delay;

    return child
        .animate(delay: entranceDelay)
        .fadeIn(duration: 400.ms, curve: Curves.easeOut)
        .moveY(
          begin: 28.h,
          end: 0,
          duration: 400.ms,
          curve: Curves.easeOutCubic,
        )
        .scale(
          begin: const Offset(0.96, 0.96),
          end: const Offset(1, 1),
          duration: 400.ms,
          curve: Curves.easeOutCubic,
        );
  }
}
