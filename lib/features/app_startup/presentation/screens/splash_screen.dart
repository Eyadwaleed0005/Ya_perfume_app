import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ya_perfume/app/routes/route_names.dart';
import 'package:ya_perfume/core/helper/app_system_ui.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/features/app_startup/presentation/cubit/splash_cubit.dart';
import 'package:ya_perfume/features/app_startup/presentation/cubit/splash_state.dart';
import 'package:ya_perfume/features/app_startup/presentation/widgets/splash_screen_widgets/splash_screen_content.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashCompleted) {
            Navigator.of(context).pushReplacementNamed(
              RouteNames.selectLanguage,
            );
          }
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: AppSystemUi.light(),
          child: const Scaffold(
            backgroundColor: AppColors.bgCanvas,
            body: SplashScreenContent(),
          ),
        ),
      ),
    );
  }
}