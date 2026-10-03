import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ya_perfume/core/helper/app_system_ui.dart';
import 'package:ya_perfume/core/theme/app_theme.dart';
import 'package:ya_perfume/features/questions/presentation/widgets/before_the_families_widgets/before_the_families_screen_content.dart';

class BeforeTheFamiliesScreen extends StatelessWidget {
  final AppThemeType? themeType;

  const BeforeTheFamiliesScreen({super.key, this.themeType});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.dark(),
      child: Scaffold(
        body: SafeArea(
          child: BeforeTheFamiliesScreenContent(themeType: themeType),
        ),
      ),
    );
  }
}
