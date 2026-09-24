import 'package:flutter/material.dart';

class QuesAnimation {
  const QuesAnimation._();
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
}
