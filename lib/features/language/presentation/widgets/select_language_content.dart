import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/app/routes/route_names.dart';
import 'package:ya_perfume/core/animation/app_animation.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/textstyles.dart';
import 'package:ya_perfume/features/app_startup/presentation/widgets/splash_screen_widgets/splash_background.dart';
import 'package:ya_perfume/features/language/presentation/cubit/language_cubit.dart';

import 'select_language_buttons.dart';
import 'select_language_logo.dart';

class SelectLanguageContent extends StatefulWidget {
  const SelectLanguageContent({super.key});

  @override
  State<SelectLanguageContent> createState() => _SelectLanguageContentState();
}

class _SelectLanguageContentState extends State<SelectLanguageContent> {
  bool _isNavigating = false;

  Future<void> _selectLanguage(String languageCode) async {
    if (_isNavigating) {
      return;
    }

    final cubit = context.read<LanguageCubit>();

    final selectedLocale = context.supportedLocales.firstWhere(
      (locale) => locale.languageCode == languageCode,
    );

    setState(() {
      _isNavigating = true;
    });

    try {
      await context.setLocale(selectedLocale);

      if (!mounted) {
        return;
      }

      cubit.selectLanguage(languageCode);

      await Navigator.of(context).pushNamed(RouteNames.choosePerfumeMethod);
    } finally {
      if (mounted) {
        setState(() {
          _isNavigating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;

    final textDirection = locale.languageCode == 'ar'
        ? TextDirection.rtl
        : TextDirection.ltr;

    return Stack(
      fit: StackFit.expand,
      children: [
        const SplashBackground(),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),
            child: Center(
              child: FittedBox(
                fit: BoxFit.contain,
                child: SizedBox(
                  width: 1000.w,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppAnimation.languageEntrance(
                        child: const SelectLanguageLogo(),
                      ),
                      AppAnimation.languageEntrance(
                        delay: const Duration(milliseconds: 40),
                        child: AppAnimation.languageContent(
                          animationKey: locale.toString(),
                          child: Text(
                            'select_language_instruction'.tr(context: context),
                            textAlign: TextAlign.center,
                            textDirection: textDirection,
                            style: AppTextStyle.font36textPrimarySemiBoldNoto(),
                          ),
                        ),
                      ),
                      verticalSpace(38.w / 1.h),
                      IgnorePointer(
                        ignoring: _isNavigating,
                        child: SelectLanguageButtons(
                          onLanguageSelected: _selectLanguage,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
