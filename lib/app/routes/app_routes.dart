import 'package:flutter/material.dart';
import 'package:ya_perfume/app/routes/route_names.dart';
import 'package:ya_perfume/core/animation/app_animation.dart';
import 'package:ya_perfume/core/theme/app_theme.dart';
import 'package:ya_perfume/features/questions/data/models/fragrance_family_model.dart';
import 'package:ya_perfume/features/questions/presentation/screens/before_the_families_screen.dart';
import 'package:ya_perfume/features/questions/presentation/screens/discover_fragrance_families_screen.dart';
import 'package:ya_perfume/features/questions/presentation/screens/questions_screen.dart';

class AppRoutes {
  const AppRoutes._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.beforeTheFamilies:
        final Object? args = settings.arguments;
        if (args is! AppThemeType?) {
          return null;
        }
        return AppAnimation.animatedNavigation(
          BeforeTheFamiliesScreen(themeType: args),
          settings,
          const Duration(milliseconds: 300),
        );
      case RouteNames.fragranceFamilies:
        final Object? args = settings.arguments;
        if (args is! Map<String, dynamic>) {
          return null;
        }
        return AppAnimation.animatedNavigation(
          DiscoverFragranceFamiliesScreen(
            families: args['families'] as List<FragranceFamily>,
            themeType: args['themeType'] as AppThemeType?,
          ),
          settings,
          const Duration(milliseconds: 500),
        );
      case RouteNames.questions:
        return AppAnimation.animatedNavigation(
          const QuestionsScreen(),
          settings,
          const Duration(milliseconds: 400),
        );
      default:
        return null;
    }
  }
}
