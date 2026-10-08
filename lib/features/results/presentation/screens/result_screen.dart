import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ya_perfume/core/helper/app_system_ui.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/features/results/domain/entities/perfume_result_entity.dart';
import 'package:ya_perfume/features/results/presentation/widgets/result_screen_widgets/result_screen_content.dart';

class ResultScreen extends StatelessWidget {
  final List<PerfumeResultEntity> perfumes;

  const ResultScreen({super.key, required this.perfumes});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.light(),
      child: Scaffold(
        backgroundColor: AppColors.bgCanvas,
        body: ResultScreenContent(perfumes: perfumes),
      ),
    );
  }
}
