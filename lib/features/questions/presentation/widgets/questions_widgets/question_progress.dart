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
    // Handle case where there's only one question to avoid division by zero
    // currentIndex is 1-based for display (1 for first question)
    final progress = currentIndex / (totalQuestions - 1);
    const butterflySize = 40.0;
    final halfButterfly = (butterflySize / 2).w;
    final lineWidth = 400.w - butterflySize.w;

    return SizedBox(
      width: 400.w,
      height: 50.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: halfButterfly,
            right: halfButterfly,
            top: 0,
            bottom: 0,
            child: Center(
              child: Container(
                height: 0.5.h,
                color: AppColors.mutedGray.withValues(alpha: 0.4),
              ),
            ),
          ),

          Positioned(
            right: halfButterfly,
            top: 0,
            bottom: 0,
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                height: 0.5.h,
                width: lineWidth * progress,
                color: AppColors.goldAccent,
              ),
            ),
          ),

          ...List.generate(totalQuestions - 1, (i) {
            final actualIndex = i + 1;
            final dotProgress = actualIndex / (totalQuestions - 1);
            final isPassed = actualIndex <= currentIndex;

            final dotRight = halfButterfly + lineWidth * (dotProgress) - 3.w;

            return Positioned(
              right: dotRight,
              top: 0,
              bottom: 0,
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  width: 6.w,
                  height: 6.w,
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

          AnimatedPositioned(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            right: lineWidth * (progress) - 2.w,
            top: 0,
            bottom: 0,
            child: Center(
              child: SvgPicture.asset(
                AppImage().butterProgressBar,
                width: butterflySize.w,
                height: butterflySize.w,
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
