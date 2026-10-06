import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    textDirection: TextDirection.ltr,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ChoosePerfumeMethodBackButton(),
                      horizontalSpace(16),
                      const Flexible(
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: ChoosePerfumeMethodIntro(),
                          ),
                        ),
                      ),
                      horizontalSpace(64),
                    ],
                  ),
                  verticalSpace(80),
                  const Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: ChoosePerfumeMethodCards(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
