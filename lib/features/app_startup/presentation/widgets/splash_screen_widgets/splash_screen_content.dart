import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/core/animation/app_animation.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/features/app_startup/presentation/cubit/splash_cubit.dart';

import 'splash_background.dart';
import 'splash_loading_bar.dart';
import 'splash_logo.dart';

class SplashScreenContent extends StatelessWidget {
  const SplashScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const SplashBackground(),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
            child: Center(
              child: FittedBox(
                fit: BoxFit.contain,
                child: SizedBox(
                  width: 400.w,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppAnimation.splashFade(child: const SplashLogo()),
                      verticalSpace(15.w / 1.h),
                      AppAnimation.splashFade(
                        delay: const Duration(milliseconds: 150),
                        child: const SizedBox.shrink()
                            .animate(
                              onComplete: (_) {
                                if (!context.mounted) return;

                                context.read<SplashCubit>().completeLoading();
                              },
                            )
                            .custom(
                              duration: 6.seconds,
                              begin: 0,
                              end: 1,
                              curve: Curves.linear,
                              builder: (context, value, child) {
                                return SplashLoadingBar(progress: value);
                              },
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
