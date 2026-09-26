import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ya_perfume/core/helper/app_system_ui.dart';
import 'package:ya_perfume/core/theme/app_theme.dart';
import 'package:ya_perfume/features/questions/data/models/fragrance_family_model.dart';
import 'package:ya_perfume/features/questions/presentation/widgets/discover_fragrance_families_widget/discover_fragrance_families_screen_content.dart';

class DiscoverFragranceFamiliesScreen extends StatelessWidget {
  final List<FragranceFamily> families;
  final AppThemeType? themeType;

  const DiscoverFragranceFamiliesScreen({
    super.key,
    required this.families,
    this.themeType,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.dark(),
      child: Scaffold(
        body: DiscoverFragranceFamiliesScreenContent(
          families: families,
          themeType: themeType,
        ),
      ),
    );
  }
}
