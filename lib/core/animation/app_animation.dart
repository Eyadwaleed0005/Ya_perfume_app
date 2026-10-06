import 'package:flutter/material.dart';
import 'package:ya_perfume/core/animation/app_startup_animation_widget.dart';
import 'package:ya_perfume/core/animation/language_animation_widget.dart';
import 'package:ya_perfume/core/animation/percentage_selection_animation.dart';
import 'package:ya_perfume/core/animation/ques_animation.dart';
import 'package:ya_perfume/core/animation/splash_animation_widget.dart';

class AppAnimation {
  const AppAnimation._();

  static PageRouteBuilder<dynamic> animatedNavigation(
    Widget page,
    RouteSettings settings,
    Duration transitionDuration,
  ) {
    return QuesAnimation.fadeRoute(
      page,
      settings,
      transitionDuration,
    );
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

  static Widget animatedImageSwitcher({
    required Widget child,
  }) {
    return QuesAnimation.animatedImageSwitcher(child: child);
  }

  static Widget animatedContentSwitcher({
    required Widget child,
  }) {
    return QuesAnimation.animatedContentSwitcher(child: child);
  }

  static Widget languageEntrance({
    required Widget child,
    Duration delay = Duration.zero,
  }) {
    return LanguageAnimationWidget.entrance(
      delay: delay,
      child: child,
    );
  }

  static Widget languageContent({
    required Widget child,
    required Object animationKey,
  }) {
    return LanguageAnimationWidget.content(
      animationKey: animationKey,
      child: child,
    );
  }

  static Widget languageSelection({
    required Widget child,
    required bool isSelected,
  }) {
    return LanguageAnimationWidget.selection(
      isSelected: isSelected,
      child: child,
    );
  }

  static Widget appStartupEntrance({
    required Widget child,
    Duration delay = Duration.zero,
  }) {
    return AppStartupAnimationWidget.entrance(
      delay: delay,
      child: child,
    );
  }

  static Widget splashFade({
    required Widget child,
    Duration delay = Duration.zero,
  }) {
    return SplashAnimationWidget.fade(
      delay: delay,
      child: child,
    );
  }

  static Widget percentageSelectionEntrance({
    required Widget child,
    Duration delay = Duration.zero,
  }) {
    return PercentageSelectionAnimation.entrance(
      delay: delay,
      child: child,
    );
  }

  static Widget percentageSelectionButterflyFlight({
    required Widget child,
    double flightRadius = 120,
  }) {
    return PercentageSelectionAnimation.butterflyFlight(
      flightRadius: flightRadius,
      child: child,
    );
  }
}