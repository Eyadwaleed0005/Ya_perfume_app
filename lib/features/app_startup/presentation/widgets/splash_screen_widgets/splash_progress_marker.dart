import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ya_perfume/app/routes/app_images_routes.dart';
import 'package:ya_perfume/core/style/app_color.dart';

class SplashProgressMarker extends StatelessWidget {
  const SplashProgressMarker({
    super.key,
    required this.size,
    this.isLoading = true,
  });

  final double size;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final marker = SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Transform.translate(
              offset: const Offset(1.5, 1.5),
              child: SvgPicture.asset(
                AppImage().splashProgressMarker,
                fit: BoxFit.contain,
                colorFilter: const ColorFilter.mode(
                  AppColors.ultraBlack,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: SvgPicture.asset(
              AppImage().splashProgressMarker,
              fit: BoxFit.contain,
              colorFilter: const ColorFilter.mode(
                AppColors.pureWhite,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );

    if (!isLoading) return marker;

    return marker
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .scale(
          begin: const Offset(0.65, 1),
          end: const Offset(1, 1),
          duration: 180.ms,
          curve: Curves.easeInOut,
        );
  }
}
