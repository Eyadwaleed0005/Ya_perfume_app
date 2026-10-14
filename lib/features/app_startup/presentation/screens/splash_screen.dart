import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ya_perfume/app/di/service_locator.dart';
import 'package:ya_perfume/app/routes/route_names.dart';
import 'package:ya_perfume/core/helper/app_system_ui.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/features/app_activation/presentation/cubit/app_activation_cubit.dart';
import 'package:ya_perfume/features/app_activation/presentation/cubit/app_activation_state.dart';
import 'package:ya_perfume/features/app_activation/presentation/screens/app_activation_screen.dart';
import 'package:ya_perfume/features/app_startup/presentation/cubit/splash_cubit.dart';
import 'package:ya_perfume/features/app_startup/presentation/cubit/splash_state.dart';
import 'package:ya_perfume/features/app_startup/presentation/widgets/splash_screen_widgets/splash_screen_content.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(create: (_) => SplashCubit()),
        BlocProvider<AppActivationCubit>(
          create: (_) => getIt<AppActivationCubit>(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<SplashCubit, SplashState>(
            listener: (context, state) {
              if (state is SplashCompleted) {
                context.read<AppActivationCubit>().getAppActivation();
              }
            },
          ),
          BlocListener<AppActivationCubit, AppActivationState>(
            listener: (context, state) {
              if (state is AppActivationSuccess) {
                if (!state.isActive) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(
                      builder: (_) => const AppActivationScreen(),
                    ),
                  );
                  return;
                }

                Navigator.of(context)
                    .pushReplacementNamed(RouteNames.selectLanguage);
              } else if (state is AppActivationFailure) {
                Navigator.of(context)
                    .pushReplacementNamed(RouteNames.selectLanguage);
              }
            },
          ),
        ],
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: AppSystemUi.dark(),
          child: const Scaffold(
            backgroundColor: AppColors.bgCanvas,
            body: SplashScreenContent(),
          ),
        ),
      ),
    );
  }
}
