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
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: SizedBox(
                  width: 1100.w,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 100.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          textDirection: TextDirection.ltr,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppAnimation.appStartupEntrance(
                              child: const ChoosePerfumeMethodBackButton(),
                            ),
                            horizontalSpace(16),
                            const Expanded(
                              child: Center(child: ChoosePerfumeMethodIntro()),
                            ),
                            horizontalSpace(64),
                          ],
                        ),
                        verticalSpace(80),
                        const ChoosePerfumeMethodCards(),
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
