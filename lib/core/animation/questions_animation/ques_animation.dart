import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuesAnimation {
  const QuesAnimation._();

  // Page transition - fade
  static PageRouteBuilder<dynamic> fadeRoute(
    Widget page,
    RouteSettings settings,
    Duration transitionDuration,
  ) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          child: child,
        );
      },
      transitionDuration: transitionDuration,
      reverseTransitionDuration: transitionDuration,
    );
  }

  // Background color transition
  static Widget animatedBackground({
    required Color backgroundColor,
    required Color primaryColor,
    required Color secondaryColor,
    required Widget child,
  }) {
    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(begin: backgroundColor, end: backgroundColor),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      builder: (context, color, _) {
        return ColoredBox(color: color ?? backgroundColor, child: child);
      },
    );
  }

  // Option selection indicator transition
  static Widget animatedSelectionIndicator({
    required bool isSelected,
    required Widget selectedWidget,
    required Widget unselectedWidget,
  }) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      child: isSelected
          ? KeyedSubtree(key: const ValueKey('selected'), child: selectedWidget)
          : KeyedSubtree(
              key: const ValueKey('unselected'),
              child: unselectedWidget,
            ),
    );
  }

  // Option container transition
  static BoxDecoration animatedOptionDecoration({
    required bool isSelected,
    required Color borderOnColor,
    required Color borderOffColor,
    required Color surfaceOnColor,
    required Color surfaceOffColor,
    required double borderRadius,
  }) {
    return BoxDecoration(
      border: Border.all(
        color: isSelected ? borderOnColor : borderOffColor,
        // RULE 1: border width must scale with screen
        width: 0.5.w,
      ),
      // RULE 9: borderRadius uses .r
      borderRadius: BorderRadius.circular(borderRadius),
      color: isSelected ? surfaceOnColor : surfaceOffColor,
    );
  }

  // Image switcher transition
  static Widget animatedImageSwitcher({required Widget child}) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: child,
    );
  }

  // Question content switcher transition
  static Widget animatedContentSwitcher({required Widget child}) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      layoutBuilder: (currentChild, previousChildren) {
        return Stack(
          fit: StackFit.expand,
          children: [
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        );
      },
      child: child,
    );
  }
}
