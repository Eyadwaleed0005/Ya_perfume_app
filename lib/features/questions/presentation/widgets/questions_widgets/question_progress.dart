import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ya_perfume/app/routes/app_images_routes.dart';
import 'package:ya_perfume/core/style/app_color.dart';

class QuestionProgress extends StatelessWidget {
  final int currentIndex;
  final int totalQuestions;

  const QuestionProgress({
    super.key,
    required this.currentIndex,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final progress = currentIndex / (totalQuestions);

    // RULE 1 & 7: butterfly icon uses .r so it scales proportionally on all screens
    final butterflySize = 40.r;
    final halfButterfly = butterflySize / 2;
    final lineWidth = 400.w - butterflySize;

    return SizedBox(
      width: 400.w,
      height: 50.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background line
          Positioned(
            left: halfButterfly,
            right: halfButterfly,
            top: 0,
            bottom: 0,
            child: Center(
              child: Container(
                // RULE 1: .h for heights
                height: 0.5.h,
                color: AppColors.mutedGray.withValues(alpha: 0.4),
              ),
            ),
          ),

          // Progress line (animated)
          Positioned(
            right: halfButterfly,
            top: 0,
            bottom: 0,
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                // RULE 1: .h for heights
                height: 0.5.h,
                width: lineWidth * progress,
                color: AppColors.goldAccent,
              ),
            ),
          ),

          // Step dots
          ...List.generate(totalQuestions, (i) {
            final actualIndex = i + 1;
            final dotProgress = actualIndex / (totalQuestions);
            final isPassed = actualIndex <= currentIndex;

            final dotRight = halfButterfly + lineWidth * (dotProgress) - 3.w;

            return Positioned(
              right: dotRight,
              top: 0,
              bottom: 0,
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  // RULE 1: use .r for uniform dot (same w & h)
                  width: 6.r,
                  height: 6.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isPassed
                        ? AppColors.goldAccent
                        : AppColors.mutedGray.withValues(alpha: 0.4),
                  ),
                ),
              ),
            );
          }),

          // Butterfly indicator (animated position)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            right: lineWidth * (progress) - 2.w,
            top: 0,
            bottom: 0,
            child: Center(
              child: SvgPicture.asset(
                AppImage().butterProgressBar,
                // RULE 7: icon/image sizes use .r
                width: butterflySize,
                height: butterflySize,
                colorFilter: const ColorFilter.mode(
                  AppColors.goldAccent,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
