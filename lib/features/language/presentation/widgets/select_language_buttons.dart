import 'package:flutter/material.dart';
import 'package:ya_perfume/app/routes/app_images_routes.dart';
import 'package:ya_perfume/core/animation/app_animation.dart';
import 'package:ya_perfume/core/helper/spacer.dart';

import 'select_language_button.dart';

class SelectLanguageButtons extends StatelessWidget {
  const SelectLanguageButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.ltr,
      children: [
        AppAnimation.languageEntrance(
          delay: const Duration(milliseconds: 80),
          child: SelectLanguageButton(
            imagePath: AppImage().frenchLanguageFlag,
            languageCode: 'fr',
          ),
        ),
        horizontalSpace(16),
        AppAnimation.languageEntrance(
          delay: const Duration(milliseconds: 120),
          child: SelectLanguageButton(
            imagePath: AppImage().englishLanguageFlag,
            languageCode: 'en',
          ),
        ),
        horizontalSpace(16),
        AppAnimation.languageEntrance(
          delay: const Duration(milliseconds: 160),
          child: SelectLanguageButton(
            imagePath: AppImage().arabicLanguageFlag,
            languageCode: 'ar',
          ),
        ),
        horizontalSpace(16),
        AppAnimation.languageEntrance(
          delay: const Duration(milliseconds: 200),
          child: SelectLanguageButton(
            imagePath: AppImage().russianLanguageFlag,
            languageCode: 'ru',
          ),
        ),
        horizontalSpace(16),
        AppAnimation.languageEntrance(
          delay: const Duration(milliseconds: 240),
          child: SelectLanguageButton(
            imagePath: AppImage().italianLanguageFlag,
            languageCode: 'it',
          ),
        ),
      ],
    );
  }
}
