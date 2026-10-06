import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashAnimationWidget extends StatelessWidget {
  const SplashAnimationWidget.fade({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  final Widget child;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    return child.animate(delay: delay).fadeIn(
      duration: 500.ms,
      curve: Curves.easeOut,
    );
  }
}