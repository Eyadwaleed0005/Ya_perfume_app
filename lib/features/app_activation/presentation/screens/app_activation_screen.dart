import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ya_perfume/app/di/service_locator.dart';
import 'package:ya_perfume/app/routes/route_names.dart';
import 'package:ya_perfume/core/helper/app_system_ui.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/features/app_activation/presentation/cubit/app_activation_cubit.dart';
import 'package:ya_perfume/features/app_activation/presentation/cubit/app_activation_state.dart';
import 'package:ya_perfume/features/app_activation/presentation/widgets/app_activation_screen_content.dart';
import 'package:ya_perfume/features/app_startup/presentation/widgets/splash_screen_widgets/splash_background.dart';

class AppActivationScreen extends StatelessWidget {
  const AppActivationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppActivationCubit>(
      create: (_) => getIt<AppActivationCubit>(),
      child: BlocConsumer<AppActivationCubit, AppActivationState>(
        listener: (context, state) {
          if (state is AppActivationFailure ||
              (state is AppActivationSuccess && state.isActive)) {
            Navigator.of(context)
                .pushReplacementNamed(RouteNames.selectLanguage);
          }
        },
        builder: (context, state) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: AppSystemUi.light(),
            child: Scaffold(
              backgroundColor: AppColors.bgCanvas,
              body: Stack(
                fit: StackFit.expand,
                children: [
                  const SplashBackground(),
                  SafeArea(
                    child: AppActivationScreenContent(
                      isChecking: state is AppActivationLoading,
                      onCheckActivation: () {
                        context.read<AppActivationCubit>().getAppActivation();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
