import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PercentageSelectionAnimation {
  const PercentageSelectionAnimation._();

  static Widget entrance({
    required Widget child,
    Duration delay = Duration.zero,
  }) {
    return child
        .animate(delay: delay)
        .fadeIn(
          duration: const Duration(milliseconds: 550),
          curve: Curves.easeOut,
        )
        .slideY(
          begin: 0.12,
          end: 0,
          duration: const Duration(milliseconds: 550),
          curve: Curves.easeOutCubic,
        );
  }

  static Widget butterflyFlight({
    required Widget child,
    double flightRadius = 120,
  }) {
    return child
        .animate(onPlay: (controller) => controller.repeat())
        .custom(
          duration: const Duration(seconds: 7),
          curve: Curves.linear,
          builder: (context, value, child) {
            // ٥ ثواني حركة، وبعدها ثانيتين ثبات.
            final time = value * 7;

            if (time >= 5) {
              return child;
            }

            final progressValue = time / 5;
            final Offset position;

            if (progressValue < 0.2) {
              final progress = Curves.easeInOut.transform(progressValue / 0.2);

              position = Offset(-flightRadius * progress, 0);
            } else if (progressValue < 0.8) {
              final progress = Curves.easeInOut.transform(
                (progressValue - 0.2) / 0.6,
              );

              final angle = progress * math.pi;

              position = Offset(
                -flightRadius * math.cos(angle),
                flightRadius * math.sin(angle),
              );
            } else {
              final progress = Curves.easeInOut.transform(
                (progressValue - 0.8) / 0.2,
              );

              position = Offset(flightRadius * (1 - progress), 0);
            }

            final settling = progressValue < 0.8
                ? 1.0
                : 1 - Curves.easeInOut.transform((progressValue - 0.8) / 0.2);

            final flap = (1 - math.cos(progressValue * math.pi * 2 * 16)) / 2;

            final wingScale = 1 - flap * 0.35 * settling;
            final tilt = math.sin(progressValue * math.pi * 2) * 0.2 * settling;

            return Transform.translate(
              offset: position,
              child: Transform.rotate(
                angle: tilt,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.diagonal3Values(wingScale, 1, 1),
                  child: child,
                ),
              ),
            );
          },
        );
  }
}
