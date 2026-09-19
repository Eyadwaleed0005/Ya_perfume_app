import 'package:flutter/material.dart';

class AppRoutes {
  const AppRoutes._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      /* case RouteNames.home:
        return MaterialPageRoute(builder: (context) => const SplashScreen()); */
      default:
        return null;
    }
  }
}
