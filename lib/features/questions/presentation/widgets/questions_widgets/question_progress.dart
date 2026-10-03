import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ya_perfume/app/routes/app_images_routes.dart';
import 'package:ya_perfume/core/style/app_color.dart';

class QuestionProgress extends StatefulWidget {
  final int currentIndex;
  final int totalQuestions;

  const QuestionProgress({
    super.key,
    required this.currentIndex,
    required this.totalQuestions,
  });

  @override
  State<QuestionProgress> createState() => _QuestionProgressState();
}

class _QuestionProgressState extends State<QuestionProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 0.70,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 0.70,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
    ]).animate(_controller);

    _startAnimation();
  }

  void _startAnimation() async {
    while (mounted) {
      await _controller.repeat(count: 2);
      _controller.reset();
      await Future.delayed(const Duration(seconds: 7));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = widget.currentIndex / widget.totalQuestions;
    final butterflySize = 40.r;
    final halfButterfly = butterflySize / 2;
    final lineWidth = 400.w - butterflySize;

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

          ...List.generate(widget.totalQuestions, (i) {
            final actualIndex = i + 1;
            final dotProgress = actualIndex / widget.totalQuestions;
            final isPassed = actualIndex <= widget.currentIndex;
            final dotRight = halfButterfly + lineWidth * dotProgress - 3.w;

            return Positioned(
              right: dotRight,
              top: 0,
              bottom: 0,
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
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

          AnimatedPositioned(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            right: lineWidth * progress - 2.w,
            top: 0,
            bottom: 0,
            child: Center(
              child: AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scaleX: _scaleAnimation.value,
                    child: child,
                  );
                },
                child: SvgPicture.asset(
                  AppImage().butterProgressBar,
                  width: butterflySize,
                  height: butterflySize,
                  colorFilter: const ColorFilter.mode(
                    AppColors.goldAccent,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
