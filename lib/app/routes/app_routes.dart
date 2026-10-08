import 'package:flutter/material.dart';
import 'package:ya_perfume/app/routes/route_names.dart';
import 'package:ya_perfume/core/animation/app_animation.dart';
import 'package:ya_perfume/core/theme/app_theme.dart';
import 'package:ya_perfume/features/app_startup/presentation/screens/choose_perfume_method_screen.dart';
import 'package:ya_perfume/features/app_startup/presentation/screens/splash_screen.dart';
import 'package:ya_perfume/features/language/presentation/screens/select_language_screen.dart';
import 'package:ya_perfume/features/percentage_selection/presentation/screens/percentage_selection_loading_screen.dart';
import 'package:ya_perfume/features/percentage_selection/presentation/screens/percentage_selection_screen.dart';
import 'package:ya_perfume/features/questions/data/models/fragrance_family_model.dart';
import 'package:ya_perfume/features/questions/presentation/screens/before_the_families_screen.dart';
import 'package:ya_perfume/features/questions/presentation/screens/discover_fragrance_families_screen.dart';
import 'package:ya_perfume/features/questions/presentation/screens/questions_screen.dart';
import 'package:ya_perfume/features/results/domain/entities/perfume_result_entity.dart';
import 'package:ya_perfume/features/results/presentation/screens/perfume_details_screen.dart';
import 'package:ya_perfume/features/results/presentation/screens/result_screen.dart';

class AppRoutes {
  const AppRoutes._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const SplashScreen(),
        );

      case RouteNames.choosePerfumeMethod:
        return AppAnimation.animatedNavigation(
          const ChoosePerfumeMethodScreen(),
          settings,
          const Duration(milliseconds: 400),
        );

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

      case RouteNames.selectLanguage:
        return AppAnimation.animatedNavigation(
          const SelectLanguageScreen(),
          settings,
          const Duration(milliseconds: 400),
        );

      case RouteNames.percentageSelection:
        return AppAnimation.animatedNavigation(
          const PercentageSelectionScreen(),
          settings,
          const Duration(milliseconds: 400),
        );

      case RouteNames.percentageSelectionLoading:
        return AppAnimation.animatedNavigation(
          const PercentageSelectionLoadingScreen(),
          settings,
          const Duration(milliseconds: 400),
        );

      case RouteNames.result:
        final args = settings.arguments;

        if (args is! List<PerfumeResultEntity>) {
          return null;
        }

        return AppAnimation.animatedNavigation(
          ResultScreen(perfumes: args),
          settings,
          const Duration(milliseconds: 400),
        );

      case RouteNames.perfumeDetails:
        final args = settings.arguments;

        if (args is! PerfumeResultEntity) {
          return null;
        }

        return AppAnimation.animatedNavigation(
          PerfumeDetailsScreen(perfume: args),
          settings,
          const Duration(milliseconds: 400),
        );

      default:
        return null;
    }
  }
}
