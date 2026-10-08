import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ya_perfume/core/helper/app_system_ui.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/features/percentage_selection/presentation/widgets/percentage_selection_loading_screen_widgets/percentage_selection_loading_content.dart';

class PercentageSelectionLoadingScreen extends StatelessWidget {
  const PercentageSelectionLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.dark(),
      child: const PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: AppColors.bgCanvas,
          body: PercentageSelectionLoadingContent(),
        ),
      ),
    );
  }
}