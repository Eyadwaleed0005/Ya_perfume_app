import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ya_perfume/core/helper/app_system_ui.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/features/results/domain/entities/perfume_result_entity.dart';
import 'package:ya_perfume/features/results/presentation/widgets/perfume_details_screen_widgets/perfume_details_screen_content.dart';

class PerfumeDetailsScreen extends StatelessWidget {
  final PerfumeResultEntity perfume;

  const PerfumeDetailsScreen({
    super.key,
    required this.perfume,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.light(),
      child: Scaffold(
        backgroundColor: AppColors.bgCanvas,
        body: PerfumeDetailsScreenContent(
          perfume: perfume,
        ),
      ),
    );
  }
}