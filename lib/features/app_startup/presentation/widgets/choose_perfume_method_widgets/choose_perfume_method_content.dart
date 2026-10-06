import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/core/animation/app_animation.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/features/app_startup/presentation/widgets/splash_screen_widgets/splash_background.dart';

import 'choose_perfume_method_back_button.dart';
import 'choose_perfume_method_cards.dart';
import 'choose_perfume_method_intro.dart';

class ChoosePerfumeMethodContent extends StatelessWidget {
  const ChoosePerfumeMethodContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const SplashBackground(),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 24.h),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 12.h),
                    child: SizedBox(
                      width: 1100.w,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const ChoosePerfumeMethodIntro(),
                          verticalSpace(60),
                          const ChoosePerfumeMethodCards(),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 80.w, top: 12.h),
                    child: AppAnimation.appStartupEntrance(
                      child: const ChoosePerfumeMethodBackButton(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
