import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ya_perfume/core/helper/app_system_ui.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/features/app_startup/presentation/widgets/choose_perfume_method_widgets/choose_perfume_method_content.dart';

class ChoosePerfumeMethodScreen extends StatelessWidget {
  const ChoosePerfumeMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.dark(),
      child: const Scaffold(
        backgroundColor: AppColors.bgCanvas,
        body: ChoosePerfumeMethodContent(),
      ),
    );
  }
}
