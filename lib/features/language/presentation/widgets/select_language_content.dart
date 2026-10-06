import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/app/routes/route_names.dart';
import 'package:ya_perfume/core/animation/app_animation.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/textstyles.dart';
import 'package:ya_perfume/core/widgets/custom_button.dart';
import 'package:ya_perfume/features/app_startup/presentation/widgets/splash_screen_widgets/splash_background.dart';

import 'select_language_buttons.dart';
import 'select_language_logo.dart';

class SelectLanguageContent extends StatelessWidget {
  const SelectLanguageContent({super.key});

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
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: SizedBox(
                  width: 1000.w,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 100.h),
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
                              'select_language_instruction'.tr(
                                context: context,
                              ),
                              textAlign: TextAlign.center,
                              textDirection: textDirection,
                              style:
                                  AppTextStyle.font36textPrimarySemiBoldNoto(),
                            ),
                          ),
                        ),
                        verticalSpace(38),
                        const SelectLanguageButtons(),
                        verticalSpace(60),
                        AppAnimation.languageEntrance(
                          delay: const Duration(milliseconds: 280),
                          child: AppAnimation.languageContent(
                            animationKey: locale.toString(),
                            child: CustomButton(
                              text: 'start'.tr(context: context),
                              width: 210.w,
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(RouteNames.choosePerfumeMethod);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
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
