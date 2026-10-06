import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/app/routes/app_images_routes.dart';
import 'package:ya_perfume/core/animation/app_animation.dart';

import 'select_language_button.dart';

class SelectLanguageButtons extends StatelessWidget {
  const SelectLanguageButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      textDirection: TextDirection.ltr,
      spacing: 16.w,
      runSpacing: 16.h,
      children: [
        AppAnimation.languageEntrance(
          delay: const Duration(milliseconds: 80),
          child: SelectLanguageButton(
            imagePath: AppImage().frenchLanguageFlag,
            languageCode: 'fr',
          ),
        ),
        AppAnimation.languageEntrance(
          delay: const Duration(milliseconds: 120),
          child: SelectLanguageButton(
            imagePath: AppImage().englishLanguageFlag,
            languageCode: 'en',
          ),
        ),
        AppAnimation.languageEntrance(
          delay: const Duration(milliseconds: 160),
          child: SelectLanguageButton(
            imagePath: AppImage().arabicLanguageFlag,
            languageCode: 'ar',
          ),
        ),
        AppAnimation.languageEntrance(
          delay: const Duration(milliseconds: 200),
          child: SelectLanguageButton(
            imagePath: AppImage().russianLanguageFlag,
            languageCode: 'ru',
          ),
        ),
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