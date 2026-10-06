import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/core/style/app_color.dart';

enum _LanguageAnimationType { entrance, content, selection }

class LanguageAnimationWidget extends StatelessWidget {
  const LanguageAnimationWidget.entrance({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  }) : _type = _LanguageAnimationType.entrance,
       animationKey = null,
       isSelected = false;

  const LanguageAnimationWidget.content({
    super.key,
    required this.child,
    required this.animationKey,
  }) : _type = _LanguageAnimationType.content,
       delay = Duration.zero,
       isSelected = false;

  const LanguageAnimationWidget.selection({
    super.key,
    required this.child,
    required this.isSelected,
  }) : _type = _LanguageAnimationType.selection,
       delay = Duration.zero,
       animationKey = null;

  final Widget child;
  final Duration delay;
  final Object? animationKey;
  final bool isSelected;
  final _LanguageAnimationType _type;

  @override
  Widget build(BuildContext context) {
    switch (_type) {
      case _LanguageAnimationType.entrance:
        return child
            .animate(delay: delay)
            .fadeIn(duration: 250.ms, curve: Curves.easeOut)
            .moveY(
              begin: 8.h,
              end: 0,
              duration: 250.ms,
              curve: Curves.easeOutCubic,
            );

      case _LanguageAnimationType.content:
        return child
            .animate(key: ValueKey(animationKey))
            .fadeIn(duration: 180.ms, curve: Curves.easeOut)
            .moveY(
              begin: 4.h,
              end: 0,
              duration: 180.ms,
              curve: Curves.easeOutCubic,
            );

      case _LanguageAnimationType.selection:
        return child
            .animate(target: isSelected ? 1 : 0)
            .custom(
              duration: 180.ms,
              curve: Curves.easeOutCubic,
              begin: 0,
              end: 1,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: 0.82 + (0.18 * value),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.bgCanvas,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: Color.lerp(
                          AppColors.veryDarkGrayishBlue,
                          AppColors.goldAccent,
                          value,
                        )!,
                        width: 2.w,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.goldAccent.withValues(
                            alpha: 0.2 * value,
                          ),
                          blurRadius: 12.r,
                          offset: Offset(0, 4.h),
                        ),
                      ],
                    ),
                    child: child,
                  ),
                );
              },
            );
    }
  }
}
