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
}
