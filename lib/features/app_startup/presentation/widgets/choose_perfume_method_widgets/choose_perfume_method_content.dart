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
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 24.h),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 1100.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AppAnimation.appStartupEntrance(
                        delay: const Duration(milliseconds: 100),
                        child: const ChoosePerfumeMethodBackButton(),
                      ),
                    ),
                    verticalSpace(16),
                    AppAnimation.appStartupEntrance(
                      delay: const Duration(milliseconds: 250),
                      child: const ChoosePerfumeMethodIntro(),
                    ),
                    verticalSpace(60),
                    const ChoosePerfumeMethodCards(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
