import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ya_perfume/app/routes/app_images_routes.dart';
import 'package:ya_perfume/core/style/app_color.dart';

class SplashBackground extends StatelessWidget {
  const SplashBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final butterflyPath = AppImage().butterflySplash;

    return RepaintBoundary(
      child: ColoredBox(
        color: AppColors.bgCanvas,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final shortestSide = constraints.biggest.shortestSide;

            return Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.hardEdge,
              children: [
                for (final butterfly in _butterflies)
                  Align(
                    alignment: butterfly.alignment,
                    child: Transform.rotate(
                      angle: butterfly.rotation,
                      child: SvgPicture.asset(
                        butterflyPath,
                        width: shortestSide * butterfly.size,
                        fit: BoxFit.contain,
                        colorFilter: ColorFilter.mode(
                          AppColors.goldAccent.withValues(
                            alpha: butterfly.opacity,
                          ),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Butterfly {
  const _Butterfly({
    required this.alignment,
    this.size = 0.14,
    this.opacity = 0.12,
    this.rotation = 0,
  });

  final Alignment alignment;
  final double size;
  final double opacity;
  final double rotation;
}

const _butterflies = [
  _Butterfly(alignment: Alignment(-0.85, -0.78)),
  _Butterfly(alignment: Alignment(-0.48, -0.94), size: 0.10),
  _Butterfly(alignment: Alignment(0.0, -0.86), size: 0.10),
  _Butterfly(alignment: Alignment(0.58, -0.90), size: 0.11),
  _Butterfly(alignment: Alignment(0.90, -0.80), size: 0.16),
  _Butterfly(
    alignment: Alignment(0.58, -0.45),
    size: 0.25,
    opacity: 0.19,
    rotation: 0.3,
  ),
  _Butterfly(alignment: Alignment(-0.88, -0.15), size: 0.19),
  _Butterfly(alignment: Alignment(0.94, -0.05), size: 0.18),
  _Butterfly(alignment: Alignment(-0.45, 0.30), size: 0.11),
  _Butterfly(alignment: Alignment(0.55, 0.28), size: 0.12),
  _Butterfly(alignment: Alignment(-0.70, 0.78), size: 0.16),
  _Butterfly(alignment: Alignment(0.04, 0.90), size: 0.19),
  _Butterfly(alignment: Alignment(0.76, 0.72), size: 0.17),
  _Butterfly(alignment: Alignment(-0.90, 0.94), size: 0.09),
  _Butterfly(alignment: Alignment(0.94, 0.96), size: 0.10),
];
