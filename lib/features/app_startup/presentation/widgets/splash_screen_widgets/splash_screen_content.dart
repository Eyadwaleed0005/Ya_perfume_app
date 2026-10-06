import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'splash_background.dart';
import 'splash_loading_bar.dart';
import 'splash_logo.dart';

class SplashScreenContent extends StatelessWidget {
  const SplashScreenContent({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const SplashBackground(),
        const Align(alignment: Alignment(0, -0.15), child: SplashLogo()),
        Align(
          alignment: const Alignment(0, 0.4),
          child: const SizedBox.shrink().animate().custom(
            duration: 6.seconds,
            begin: 0,
            end: 1,
            curve: Curves.linear,
            builder: (context, value, child) {
              return SplashLoadingBar(progress: value);
            },
          ),
        ),
      ],
    );
  }
}
