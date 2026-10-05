import 'package:flutter/material.dart';
import 'package:ya_perfume/app/routes/route_names.dart';
import 'package:ya_perfume/features/questions/presentation/screens/questions_screen.dart';

class AppRoutes {
  const AppRoutes._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.questions:
        return MaterialPageRoute(builder: (context) => const QuestionsScreen());
      default:
        return null;
    }
  }
}
