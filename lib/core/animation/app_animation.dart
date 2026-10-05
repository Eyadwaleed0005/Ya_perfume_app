import 'package:flutter/material.dart';
import 'package:ya_perfume/core/animation/questions_animation/ques_animation.dart';

class AppAnimation {
  const AppAnimation._();

  static PageRouteBuilder<dynamic> animatedNavigation(
    Widget page,
    RouteSettings settings,
    Duration transitionDuration,
  ) {
    return QuesAnimation.fadeRoute(page, settings, transitionDuration);
  }

  static Widget animatedSelectionIndicator({
    required bool isSelected,
    required Widget selectedWidget,
    required Widget unselectedWidget,
  }) {
    return QuesAnimation.animatedSelectionIndicator(
      isSelected: isSelected,
      selectedWidget: selectedWidget,
      unselectedWidget: unselectedWidget,
    );
  }

  static Widget animatedImageSwitcher({required Widget child}) {
    return QuesAnimation.animatedImageSwitcher(child: child);
  }

  static Widget animatedContentSwitcher({required Widget child}) {
    return QuesAnimation.animatedContentSwitcher(child: child);
  }
}
